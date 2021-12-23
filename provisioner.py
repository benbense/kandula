import os
import boto3
from collections import defaultdict
import paramiko
from paramiko.rsakey import RSAKey
from scp import SCPClient


def get_bastion_host_ip(ec2):
    running_instances = ec2.instances.filter(Filters=[{
        'Name': 'tag:service_role',
        'Values': ['bastion']
    }])
    for instance in running_instances:
        for tag in instance.tags:
            if 'Name' in tag['Key']:
                name = tag['Value']
        return instance.public_ip_address


def ssh_client_connection(host_ip, private_key_file_path):
    try:
        ssh_client = paramiko.SSHClient()
        ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        private_key = RSAKey.from_private_key_file(private_key_file_path)

        ssh_client.connect(hostname=host_ip,
                           username="ubuntu", pkey=private_key)
        return ssh_client
    except:
        print("Error connecting to host '{}' using key file '{}'".format(
            host_ip, private_key_file_path))
        exit()


def scp_file_copy(ssh_session, file, remote_path):
    with SCPClient(ssh_session.get_transport()) as scp:
        scp.put(file, remote_path=remote_path)


def ssh_run_commands(ssh_session, commands: list):
    for command in commands:
        print("="*25, command, "="*25)
        stdin, stdout, stderr = ssh_session.exec_command(command)
        print(stdout.read().decode())
        err = stderr.read().decode()
        if err:
            print(err)
        else:
            print("Command Successful")


private_key_file_path = f"C:\\Keys\\kandula.pem"
ec2 = boto3.resource('ec2')

bastion_host_ip = get_bastion_host_ip(ec2)

bastion_ssh_session = ssh_client_connection(
    bastion_host_ip, private_key_file_path)

scp_file_copy(bastion_ssh_session, private_key_file_path,
              '/home/ubuntu/.ssh/id_rsa')

ssh_commands = [["chmod 600 /home/ubuntu/.ssh/id_rsa",
                 "sudo sed -i 's/#   StrictHostKeyChecking ask/    StrictHostKeyChecking no/g' /etc/ssh/ssh_config", ]]

ssh_run_commands(bastion_ssh_session, ssh_commands)
