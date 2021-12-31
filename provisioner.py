import boto3
import paramiko
import sys
import os
import time

from paramiko.rsakey import RSAKey
from scp import SCPClient
import requests
import json
from requests.models import Response

from requests.sessions import Session


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


def progress(filename, size, sent):
    sys.stdout.write(
        "Copying: %s - Progress: %.2f%%   \n"
        % (filename, float(sent) / float(size) * 100)
    )


def get_eks_cluster_name(eks):
    cluster = eks.list_clusters(maxResults=1)
    # return cluster["clusters"][0]
    return 'moshe'


def get_consul_servers_amount(ec2):
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


def get_bastion_host_ip(ec2):
    running_instances = ec2.instances.filter(
        Filters=[
            {"Name": "tag:service_role", "Values": ["bastion"]},
            {"Name": "instance-state-name", "Values": ["running"]},
        ]
    )
    for instance in running_instances:
        return instance.public_ip_address


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


def ssh_run_commands(ssh_session, commands: list):
    for command in commands:
        print("=" * 25, command, "=" * 25, "\n")
        stdin, stdout, stderr = ssh_session.exec_command(command)
        while True:
            line = stdout.readline()
            if not line:
                break
            print(line, end="")


@log_function
def deploy_terraform(var_file):
    os.chdir("Terraform")
    os.system
    os.system(f"terraform apply -var-file {var_file} --auto-approve")
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
def wait_for_plan_status(session: Session, run_id, status):
    # TODO - add max retries
    while True:
        time.sleep(3)
        response = session.get(
            f"https://app.terraform.io/api/v2/runs/{run_id}")
        if response.status_code != 200:
            exit()
        else:
            response_data = response.json()
            if response_data["data"]["attributes"]["status"] == status:
                return


@log_function
def run_plan_to_completion(session, organization_name, workspace_name):
    vpc_workspace = get_tfe_workspace_by_names(
        session,
        organization_name,
        workspace_name,
    )

    vpc_plan = plan_by_workspace(session, vpc_workspace["id"])

    vpc_plan_id = vpc_plan["data"]["id"]

    wait_for_plan_status(session, vpc_plan_id, "planned")
    apply_run_by_id(session, vpc_plan_id)
    wait_for_plan_status(session, vpc_plan_id, "applied")


############################################################################################


@log_function
def run_terraform(terraform_var_file_path, terraform_vars):
    deploy_terraform(terraform_var_file_path)

    session = create_tfe_api_session(terraform_vars["tfe_token"])

    run_plan_to_completion(
        session,
        terraform_vars["tfe_organization_name"],
        terraform_vars["vpc_workspace_name"],
    )

    run_plan_to_completion(
        session,
        terraform_vars["tfe_organization_name"],
        terraform_vars["servers_workspace_name"],
    )


@log_function
def run_ansible(terraform_vars):
    private_key_file_path = terraform_vars["private_key_path"]
    ansible_files = f"Ansible"

    ec2 = boto3.resource("ec2")
    eks = boto3.client("eks")

    eks_cluster_name = get_eks_cluster_name(eks)
    bastion_host_ip = get_bastion_host_ip(ec2)
    consul_servers_amount = get_consul_servers_amount(ec2)

    bastion_ssh_session = ssh_client_connection(
        bastion_host_ip, private_key_file_path)

    scp_file_copy(
        bastion_ssh_session, private_key_file_path, "/home/ubuntu/.ssh/id_rsa"
    )
    scp_file_copy(bastion_ssh_session, ansible_files, "~/")

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
    ]

    install_ansible_modules = [
        "ansible-galaxy collection install community.general",
        "ansible-galaxy collection install amazon.aws",
        "ansible-galaxy collection install community.docker",
    ]

    run_ansible_playbook_commands = [
        f'ansible-playbook {ansible_files}/main.yml -i {ansible_files}/aws_ec2.yml -e "consul_servers_amount={consul_servers_amount} consul_dc_name=kandula eks_cluster_name={eks_cluster_name} AWS_SECRET_ACCESS_KEY={AWS_SECRET_ACCESS_KEY}, AWS_ACCESS_KEY_ID={AWS_ACCESS_KEY_ID}"'
    ]

    ssh_run_commands(bastion_ssh_session, ssh_commands)
    ssh_run_commands(bastion_ssh_session, install_ansible_commands)
    ssh_run_commands(bastion_ssh_session, install_ansible_modules)
    ssh_run_commands(bastion_ssh_session, run_ansible_playbook_commands)

    print("Done")


def run(terraform_var_file_path):
    terraform_vars = get_terraform_vars_from_file(terraform_var_file_path)
    run_terraform(terraform_var_file_path, terraform_vars)
    run_ansible(terraform_vars)


terraform_var_file_path = sys.argv[1]
run(terraform_var_file_path)
