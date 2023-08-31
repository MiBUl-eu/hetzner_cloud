# Deploy Wordpress HA Enviroment
The Terraform Module will deploy 4 nodes. 
3 for Wordpress and one as LoadBallancer.

The 3 Wordpress nodes can only communicat in an internal network with each other and the LoadBallancer. 
The LoadBallancer will act as Proxy for the installation and will route the trafice from external to the 3 WP Nodes. 

The Ansible script will install Squid and Caddy on the LoadBallancer Node. 
On the WOrdpress Nodes it will install Galera and Wordpress as Docker Containers. 
Each will have a mount in the /opt folder. 
The Wordpress instances will use the local ip as the Database Connection IP. 


## Terraform Module
The Terraform Module has 4 Variable where 3 have default values. 

### hcloud_token
The hetzner cloud token. Please use Enviroment Variable or insert it at the terraform call.
This variable is required. 

### server_type
Witch Server Type to deploy. The default value is cx21.

### image
Witch Image to deploy. The default value is ubuntu-22.04.

### datacenter
Witch datacenter to deploy. The default value is nbg1-dc3

## Installation
For the installation you need to have ansible and terraform installed on your system. 
Also you should export your hcloud token
''' bash
export TF_VAR_hcloud_token=<YOUR TOKEN>
'''

After that please run in this folder: 

''' bash
terraform init
terraform plan
terraform apply
'''

After that you can start with the ansible script. The Ansible call will ask you for the vault password

''' bash
cd ansible
ansible-galaxy install -r roles/requirements.yml --force
ansible-playbook -i inventory/ site.yaml --ask-vault-pass
'''

After all is finished you can visit the new Wordpress Installation at https://wordpress-mb.senecops.com/