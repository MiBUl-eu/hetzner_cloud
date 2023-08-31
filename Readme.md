# Deploy WordPress HA Environment

This Terraform module automates the deployment of a high-availability WordPress environment consisting of four nodes: three for WordPress instances and one as a Load Balancer.

The three WordPress nodes are isolated in an internal network, communicating with each other and the Load Balancer. The Load Balancer acts as a proxy, routing external traffic to the three WordPress nodes.

## Ansible Configuration

The Ansible script plays a crucial role in setting up the environment:

- **Load Balancer**: Installs Squid and Caddy on the Load Balancer node.
- **WordPress Nodes**: Deploys Galera and WordPress as Docker containers, each with a mount point in the `/opt` folder. These WordPress instances use the local IP as the database connection IP.

## Terraform Module Configuration

The Terraform module includes four variables, with three of them having default values:

### `hcloud_token` (Required)
You must provide the Hetzner Cloud token, either via an environment variable or by passing it during the Terraform execution.

### `server_type` (Default: cx21)
Specify the server type to deploy. The default is set to `cx21`.

### `image` (Default: ubuntu-22.04)
Choose the image to deploy. The default image is `ubuntu-22.04`.

### `datacenter` (Default: nbg1-dc3)
Select the data center for deployment. The default data center is `nbg1-dc3`.

## Installation Instructions

To proceed with the installation, ensure that both Ansible and Terraform are installed on your system. Additionally, export your Hetzner Cloud token using the following command:

```bash
export TF_VAR_hcloud_token=<YOUR TOKEN>
```

Next, navigate to this project's folder and execute the following Terraform commands:

```bash
terraform init
terraform plan
terraform apply
```

Once the Terraform deployment completes, you can proceed with the Ansible script. During execution, Ansible will prompt you for the vault password:

```bash
cd ansible
ansible-galaxy install -r roles/requirements.yml --force
ansible-playbook -i inventory/ site.yaml --ask-vault-pass
```

After all steps are successfully executed, you can access the newly deployed WordPress installation at [https://wordpress-mb.senecops.com/](https://wordpress-mb.senecops.com/).