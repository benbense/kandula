import sys
import os
import time
import requests
import shutil
import json
import paramiko
from scp import SCPClient
from requests.sessions import Session
from paramiko.rsakey import RSAKey
from OpenSSL import crypto


def log_function(func):
    def log(*args, **kwargs):
        print("Function", func.__name__, "starts running.")
        ts = time.time()
        result = func(*args, **kwargs)
        te = time.time()
        print(
            "Function",
            func.__name__,
            "finished running!",
            "time:",
            round((te - ts) * 1000, 1),
            "ms",
        )
        print()
        return result

    return log


@log_function
def generate_ssl_cert():
    KEY_FILE = "Terraform/SSL/private.pem"
    CERT_FILE = "Terraform/SSL/selfsigned.pem"
    if os.path.exists(KEY_FILE) or os.path.exists(CERT_FILE):
        pass
    else:
        k = crypto.PKey()
        k.generate_key(crypto.TYPE_RSA, 4096)
        cert = crypto.X509()
        cert.set_serial_number(1000)
        cert.gmtime_adj_notBefore(0)
        cert.gmtime_adj_notAfter(10*365*24*60*60)
        cert.get_subject().CN = "Kandula"
        cert.set_issuer(cert.get_subject())
        cert.set_pubkey(k)
        cert.sign(k, 'sha512')
        with open(CERT_FILE, "w") as f:
            f.write(crypto.dump_certificate(
                crypto.FILETYPE_PEM, cert).decode("utf-8"))
        with open(KEY_FILE, "w") as f:
            f.write(crypto.dump_privatekey(
                crypto.FILETYPE_PEM, k).decode("utf-8"))


def progress(filename, size, sent):
    sys.stdout.write(
        "Copying: %s - Progress: %.2f%%   \n"
        % (filename, float(sent) / float(size) * 100)
    )


def get_eks_cluster_name(eks):
    # TODO Get cluster by tag
    cluster = eks.list_clusters(maxResults=1)
    return cluster["clusters"][0]


def get_consul_servers_amount(ec2):
    # TODO Change for loop to len
    count = 0
    running_instances = ec2.instances.filter(
        Filters=[
            {"Name": "tag:service_role", "Values": ["service_discovery"]},
            {"Name": "instance-state-name", "Values": ["running"]},
        ]
    )
    for instance in running_instances:
        count = count + 1
    return count


def get_bastion_host_ip(ec2, get_public_ip: bool):
    running_instances = ec2.instances.filter(
        Filters=[
            {"Name": "tag:service", "Values": ["bastion"]},
            {"Name": "instance-state-name", "Values": ["running"]},
        ]
    )
    for instance in running_instances:
        if get_public_ip:
            return instance.public_ip_address
        else:
            return instance.private_ip_address


def get_ansible_host_private_ip(ec2):
    running_instances = ec2.instances.filter(
        Filters=[
            {"Name": "tag:service", "Values": ["ansible"]},
            {"Name": "instance-state-name", "Values": ["running"]},
        ]
    )
    for instance in running_instances:
        return instance.private_ip_address


def ssh_client_connection(host_ip, private_key_file_path):
    try:
        ssh_client = paramiko.SSHClient()
        ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        private_key = RSAKey.from_private_key_file(private_key_file_path)

        ssh_client.connect(
            hostname=host_ip, username="ubuntu", pkey=private_key)
        return ssh_client
    except:
        print(
            f"Error connecting to host '{host_ip}' using key file '{private_key_file_path}'"
        )
        exit()


def scp_file_copy(ssh_session, file, remote_path):
    with SCPClient(ssh_session.get_transport(), progress=progress) as scp:
        scp.put(file, remote_path=remote_path, recursive=True)

def scp_file_download(ssh_session, remote_path, local_path):
    with SCPClient(ssh_session.get_transport(), progress=progress) as scp:
        scp.get(remote_path, local_path)

def ssh_run_commands(ssh_session, commands: list):
    for command in commands:
        print("=" * 25, command, "=" * 25, "\n")
        stdin, stdout, stderr = ssh_session.exec_command(command)
        while True:
            line = stdout.readline()
            if not line:
                break
            print(line, end="")


def ssh_client_connection_throgh_bastion_host(bastion_ssh_session, bastion_host_private_ip, target_host_ip, ssh_user_name, private_key_file_path):
    try:
        bastion_host_transport = bastion_ssh_session.get_transport()
        src_addr = (bastion_host_private_ip, 22)
        dest_addr = (target_host_ip, 22)
        bastion_host_channel = bastion_host_transport.open_channel(
            "direct-tcpip", dest_addr, src_addr)

        target_host_ssh_client = paramiko.SSHClient()
        target_host_ssh_client.set_missing_host_key_policy(
            paramiko.AutoAddPolicy())
        target_host_ssh_client.connect(target_host_ip, username=ssh_user_name,
                                       key_filename=private_key_file_path, sock=bastion_host_channel)

        return target_host_ssh_client

    except:
        print(
            f"Error Connecting To: {0} Through Bastion Host".format(target_host_ip))
        exit()


@log_function
def deploy_terraform(var_file):
    os.chdir("Terraform")
    os.system("terraform init")
    os.system(f"terraform apply -var-file vars.tfvars --auto-approve")
    os.chdir("..")


@log_function
def get_tfe_workspace_by_names(session: Session, org_name, workspace_name):
    # TODO - Check status + check length
    response = session.get(
        f"https://app.terraform.io/api/v2/organizations/{org_name}/workspaces?search%5Bname%5D={workspace_name}"
    )
    if response.status_code != 200:
        exit()
    else:
        response = response.json()
        workspace = response["data"][0]
        workspace_dict = {}
        workspace_name = workspace["attributes"]["name"]
        workspace_dict["name"] = workspace_name
        workspace_dict["id"] = workspace["id"]

    return workspace_dict


@log_function
def create_tfe_api_session(access_token):
    session = requests.Session()
    session.headers.update(
        {
            "Authorization": f"Bearer {access_token}",
            "Content-Type": "application/vnd.api+json",
        }
    )
    return session


@log_function
def get_last_run_by_workspace(session: Session, workspace_id):
    response = session.get(
        f"https://app.terraform.io/api/v2/workspaces/{workspace_id}/runs?page%5Bnumber%5D=1&page%5Bsize%5D=1"
    ).json()
    runs_dict_list = []
    for run in response["data"]:
        run_dict = {}
        run_dict["status"] = run["attributes"]["status"]
        runs_dict_list.append(run_dict)
    return runs_dict_list


@log_function
def get_organization_variables(session: Session):
    response = session.get(
        f"https://app.terraform.io/api/v2/vars"
    ).json()
    vars_dict = {}
    for var in response['data']:
        dict_key = var['attributes']['key']
        dict_value = var['attributes']['value']
        vars_dict[dict_key] = dict_value
    return vars_dict


@log_function
def plan_by_workspace(session: Session, workspace_id):
    payload = json.dumps(
        {
            "data": {
                "attributes": {"is-destroy": False},
                "type": "runs",
                "relationships": {
                    "workspace": {"data": {"type": "workspaces", "id": workspace_id}}
                },
            }
        }
    )

    url = "https://app.terraform.io/api/v2/runs"
    response = session.post(url, payload)
    if response.status_code != 201:
        exit()
    return response.json()


@log_function
def apply_run_by_id(session: Session, run_id):
    response = session.post(
        f"https://app.terraform.io/api/v2/runs/{run_id}/actions/apply"
    )
    if response.status_code != 202:
        exit()


@log_function
def create_tfvars_file(vars_file_path):
    file_path = shutil.copy(
        vars_file_path, os.path.join('Terraform', 'vars.tfvars'))
    return file_path


@log_function
def get_terraform_vars_from_file(terraform_var_file_path):
    terraform_vars = {}
    with open(terraform_var_file_path, "r") as terraform_var_file:
        for line in terraform_var_file.readlines():
            line_parts = line.strip().split("=")
            line_var_name = line_parts[0].strip()
            line_var_value = line_parts[1].strip()
            if line_var_value[0] == '"' and line_var_value[-1] == '"':
                line_var_value = line_var_value[1:-1]
            terraform_vars[line_var_name] = line_var_value
    return terraform_vars


@log_function
def wait_for_plan_status(session: Session, run_id, statuses):
    # TODO - add max retries
    while True:
        time.sleep(5)
        response = session.get(
            f"https://app.terraform.io/api/v2/runs/{run_id}")
        if response.status_code != 200:
            exit()
        else:
            response_data = response.json()
            if response_data["data"]["attributes"]["status"] in statuses:
                return


@log_function
def get_workspace_outputs(session: Session, workspace_list):
    all_outputs = {}
    for workspace in workspace_list:
        workspace_outputs_dict = {}
        response = session.get(
            f"https://app.terraform.io/api/v2/workspaces/{workspace['id']}")
        if response.status_code != 200:
            exit()
        else:
            response_data = response.json()
            output_ids = []
            for output in response_data['data']['relationships']['outputs']['data']:
                output_ids.append(output['id'])
            for output_id in output_ids:
                response = session.get(
                    f"https://app.terraform.io/api/v2/state-version-outputs/{output_id}")
                if response.status_code != 200:
                    exit()
                else:
                    response_data = response.json()
                    dict_key = response_data['data']['attributes']['name']
                    dict_value = response_data['data']['attributes']['value']
                    workspace_outputs_dict[dict_key] = dict_value
        all_outputs[workspace['name']] = workspace_outputs_dict
    return all_outputs


@log_function
# TODO Change from vpc_worspace to global value
def run_plan_to_completion(session, workspaces):
    for workspace in workspaces:
        current_plan = plan_by_workspace(session, workspace["id"])
        current_plan_id = current_plan["data"]["id"]

        wait_for_plan_status(session, current_plan_id, [
            "planned", "planned_and_finished"])
        apply_run_by_id(session, current_plan_id)
        wait_for_plan_status(session, current_plan_id, [
            "applied", "planned_and_finished"])


############################################################################################


@log_function
def run_terraform(terraform_var_file_path, terraform_txt_vars):
    deploy_terraform(terraform_var_file_path)

    time.sleep(5)
    session = create_tfe_api_session(terraform_txt_vars["tfe_token"])
    terraform_cloud_vars = get_organization_variables(session)
    terraform_vars = {}
    terraform_vars.update(terraform_txt_vars)
    terraform_vars.update(terraform_cloud_vars)

    vpc_workspace = get_tfe_workspace_by_names(
        session, terraform_vars["tfe_organization_name"], terraform_vars["vpc_workspace_name"])
    servers_workspace = get_tfe_workspace_by_names(
        session, terraform_vars["tfe_organization_name"], terraform_vars["servers_workspace_name"])
    kubernetes_workspace = get_tfe_workspace_by_names(
        session, terraform_vars["tfe_organization_name"], terraform_vars["kubernetes_workspace_name"])
    rds_workspace = get_tfe_workspace_by_names(
        session, terraform_vars["tfe_organization_name"], terraform_vars["rds_workspace_name"])

    run_plan_to_completion(
        session, [vpc_workspace, servers_workspace, kubernetes_workspace, rds_workspace]
    )

    return get_workspace_outputs(session, [vpc_workspace, servers_workspace, kubernetes_workspace, rds_workspace])


@log_function
def run_ansible(terraform_vars, workspaces_outputs):
    private_key_file_path = terraform_vars["private_key_path"]
    github_branch = terraform_vars["github_branch"]
    ansible_files = f"/home/ubuntu/kandula/Ansible"

    eks_cluster_name = workspaces_outputs['VPC-Workspace']['cluster_name']
    bastion_host_public_ip = workspaces_outputs['Servers-Workspace']['bastion_server_public_ip'][0]
    bastion_host_private_ip = workspaces_outputs['Servers-Workspace']['bastion_server_private_ip'][0]
    ansible_host_private_ip = workspaces_outputs['Servers-Workspace']['ansible_server_private_ip'][0]
    aws_default_region = terraform_vars['aws_default_region']
    db_password = terraform_vars['db_password']
    consul_servers_amount = 3

    bastion_ssh_session = ssh_client_connection(
        bastion_host_public_ip, private_key_file_path)

    ansible_ssh_session = ssh_client_connection_throgh_bastion_host(
        bastion_ssh_session, bastion_host_private_ip, ansible_host_private_ip, "ubuntu", private_key_file_path)

    scp_file_copy(
        ansible_ssh_session, private_key_file_path, "/home/ubuntu/.ssh/id_rsa"
    )

    ssh_commands = [
        "chmod 600 /home/ubuntu/.ssh/id_rsa",
        "sudo sed -i 's/#   StrictHostKeyChecking ask/    StrictHostKeyChecking no/g' /etc/ssh/ssh_config",
    ]

    install_ansible_commands = [
        "sudo apt update",
        "sudo apt install software-properties-common",
        "sudo add-apt-repository --yes --update ppa:ansible/ansible",
        "sudo apt install ansible -y",
        "sudo apt install python-boto3 -y",
        "rm -rf /home/ubuntu/kandula",
        f"git clone -b {github_branch} https://github.com/benbense/kandula.git /home/ubuntu/kandula",
    ]

    install_ansible_modules = [
        "ansible-galaxy collection install community.general",
        "ansible-galaxy collection install community.docker",
        "ansible-galaxy collection install amazon.aws",
        "ansible-galaxy collection install community.postgresql",
    ]

    run_ansible_playbook_commands = [
        f'ansible-playbook {ansible_files}/main.yml -i {ansible_files}/aws_ec2.yml -e "consul_servers_amount={consul_servers_amount} consul_dc_name=kandula eks_cluster_name={eks_cluster_name} aws_default_region={aws_default_region} db_password={db_password}"'
    ]

    ssh_run_commands(ansible_ssh_session, ssh_commands)
    ssh_run_commands(ansible_ssh_session, install_ansible_commands)
    ssh_run_commands(ansible_ssh_session, install_ansible_modules)
    ssh_run_commands(ansible_ssh_session, run_ansible_playbook_commands)

    print("Done")

    scp_file_download(bastion_ssh_session, "/home/ubuntu/kandula.ovpn", ".")
    ssh_run_commands(bastion_ssh_session, ["rm /home/ubuntu/kandula.ovpn"])


def run(vars_file_path):

    terraform_var_file_path = create_tfvars_file(vars_file_path)
    terraform_vars = get_terraform_vars_from_file(terraform_var_file_path)
    generate_ssl_cert()
    workspaces_outputs = run_terraform(terraform_var_file_path, terraform_vars)
    run_ansible(terraform_vars, workspaces_outputs)
    print(json.dumps(workspaces_outputs, sort_keys=False, indent=4))


# vars_file_path = sys.argv[1]
vars_file_path = f"C:\\Keys\\vars.txt"
run(vars_file_path)
