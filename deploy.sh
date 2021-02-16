#!/usr/bin/env bash

ENVIRONMENT=performance
export EC2_INI_PATH='./inventory/config/dev1/ec2.ini'

chmod +x ./inventory/ec2.py
rm -rf .ansible
sudo rm -rf /etc/ansible/roles


eval `ssh-agent -s -t 4000`

ssh-add ~/.ssh/id_rsa

ssh-add ~/.ssh/nfs-temp
echo ""
echo "configure infrasturcture related to Data sync"
echo ""
cd ./datasync_terraform/
terraform init -varfile=./vars/prod.tfvars
terraform plan -varfile=./vars/prod.tfvars
terraform apply -auto-approve -varfile=./vars/prod.tfvars

echo ""
echo "Configuring software on $ENVIRONMENT environment using Ansible"
echo ""

#ansible-galaxy install -r ./oem-agent-requirements.yml

ansible-playbook \
        -e "ansible_ssh_user=ec2-user" \
        --private-key ~/.ssh/nfs-temp \
        -i ./inventory/ec2.py \
        ./playbooks/main.yml


#rm ansible-ec2*

