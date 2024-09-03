Ansible-Terraform Project
--------------------------

This repository contains Ansible playbooks and Terraform configurations for setting up and managing infrastructure on AWS. Follow the steps below to clone the repository, set up your environment, and deploy the infrastructure.

Prerequisites
- Terraform and Ansible must be installed on the same machine.
- AWS credentials must be configured on the machine where Terraform and Ansible are running.

- Cloning the Repository

1. Clone the GitHub repository:
   ```bash
   git clone <https://github.com/Mohit722/Ansible-Terraform-Project.git>
   cd Ansible-Terraform-project
   ```

2. Explore the project structure:
   Inside the `Ansible-Terraform-project` directory, you'll find:
   - `buildsetup.yml`: Ansible playbook to set up build machines.
   - `main.tf`: Terraform configuration file.
   - `demohosts`: Dynamic inventory file.
   - `roles/`: Directory containing Ansible roles.

- Setting Up Your Environment

1. Install Ansible on the Terraform machine (if not already installed):
   ```bash
   sudo apt install ansible
   ```

2. Configure AWS credentials:
   Ensure your AWS credentials are set up correctly. Add them to the `~/.bashrc` file if they are not already configured:
   ```bash
   vi ~/.bashrc
   ```

   Add the following lines which you need to create in the AWS portal:
   ```bash
   export AWS_ACCESS_KEY_ID=YourAWSAccessKeyID
   export AWS_SECRET_ACCESS_KEY=YourAWSSecretAccessKey
   ```

   Save and exit, then reload the bash profile:
   ```bash
   source ~/.bashrc
   ```

3. Handle the PEM file:
   If the PEM file is not already on your Terraform/Ansible machine, follow these steps:
   
   - Download the PEM file from AWS: 
     - Go to the AWS Management Console and navigate to the EC2 section.
     - Locate your key pair or create a new one, and download the `.pem` file.

   - Transfer the PEM file content to your Terraform/Ansible machine:
     - Open the PEM file with a text editor on your local machine and copy the entire content.
     - On your Terraform/Ansible machine, create a new PEM file in the `/etc/ansible/` directory, if require create ansible folder inside the /etc directory:
       bash
       sudo nano /etc/ansible/yourfilekey.pem
       
     - Paste the content into the file and save it.

   - Set the correct permissions:
     bash
     sudo chmod 400 /etc/ansible/yourfilekey.pem
     

   - Ensure the security group settings:
     - Make sure your AWS security group allows SSH (port 22) connections. 
     - If necessary, update the security group associated with the instances to allow port 22:
       bash
       aws ec2 authorize-security-group-ingress --group-name YourSecurityGroupName --protocol tcp --port 22 --cidr 0.0.0.0/0
       

   The PEM file is crucial for Ansible to establish SSH connections with the newly created instances during playbook execution. Ensure that the file name matches what’s specified in your playbook, and the security group allows SSH access.

- Running Terraform Commands

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Validate the Terraform configuration:
   ```bash
   terraform validate
   ```

3. Plan the infrastructure:
   ```bash
   terraform plan
   ```

4. Apply the Terraform configuration:
   ```bash
   terraform apply -auto-approve
   ```

## Verifying the Setup

After the playbook runs (typically 5-10 minutes), verify the configuration of the newly created instances in the AWS Management Console. 

- Check the newly created instances: Ensure that the build environment, including Maven and Docker, is correctly set up on the new instances.

