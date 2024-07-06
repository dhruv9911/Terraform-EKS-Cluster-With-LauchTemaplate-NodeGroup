# Introduction 
This repo is used for create EKS Cluster with Launch Template for managed NodeGroup for AMI AmazonLinux-2023 using Terraform Code

# Create EKS Cluster with all resources
terraform plan -var-file="env/sit/apps_infra.tfvars"
terraform apply -var-file="env/sit/apps_infra.tfvars"

# Delete EKS Cluster with all resources
terraform destroy -var-file="env/sit/apps_infra.tfvars" 

# Azure DevOps Pipeline Integration
Create repo in Azure Pipeline and put all code over there, and configure Azure pipeline for deploy resources from Azure pipeline to AWS Account, before that you need to setup an "Agent pool" in Azure pipeline. Create an EC2 instance in AWS account where you want to create these resources from Azure Pipeline and install "Azure-Agent" on thhat EC2 Instance, also make sure you attached "Admin-Role" on same Ec2 Instance.

