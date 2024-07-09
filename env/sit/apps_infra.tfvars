vpc_id                                     = "vpc-0abb73a834b5ff69e"
#eks_cluster_app_subnet_ids                         = ["subnet-0a1c22e098ef8a694", "subnet-00a4015b00acf9056", "subnet-0dd766778d83736c9"]
private_subnet_1_id                        = "subnet-0860aa75ed8a6f9cb"
private_subnet_2_id                        = "subnet-0b91b92e45981892e"
private_subnet_3_id                        = "subnet-0df5d9dabdb6cdc88"
environment                                =  "sit"
domain                                     =  "sbx-apps"

#==================<< Start of AWS common variables. >>================#

aws_auth_profile = "default"
resource_region  = "ap-southeast-2"
region           = "ap-southeast-2"
project          = "ado-sbx-apps"
env              = "sit"
global_suffix    = ""
resource_azs     = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]

resource_azs_name = {
  "ap-southeast-2a" = "Az1"
  "ap-southeast-2b" = "Az2"
  "ap-southeast-2c" = "Az3"
}

default_tags = {
  "Environment"   = "sit"
  "Project"       = "ado-sbx-apps"
  "Department"    = "GSIT"
  "CreatedUsing"  = "Terraform"
}

#==================<< End of AWS common variables. >>================#


#==================<< Start of EKS Cluster Security grp ingress rule variables. >>================#

eks_security_grp_ingress_rule_no = ["1"]

eks_security_grp_ingress_destination_cidr_block = {
  # VPC  CIDR is "10.219.26.0/23"
  "1" = "172.31.0.0/16"
#  "2" = "0.0.0.0/0"
}

eks_security_grp_ingress_rule_protocol = {
  "1" = "all"
#  "2" = "all"
}

eks_security_grp_ingress_rule_from_port = {
  "1" = "0"
#  "2" = "0"

}

eks_security_grp_ingress_rule_to_port = {
  "1" = "0"
#  "2" = "0"
}

eks_security_grp_ingress_rule_self_flag = {
  "1" = "false"
#  "2" = "false"
}

#==================<< End of EKS Cluster Security grp ingress rule variables. >>================#
#==================<< Start of EKS Cluster Security grp engress rule variables. >>================#

eks_security_grp_egress_rule_no = ["1"]

eks_security_grp_egress_destination_cidr_block = {
  "1" = "0.0.0.0/0"
}

eks_security_grp_egress_rule_protocol = {
  "1" = "all"
}

eks_security_grp_egress_rule_from_port = {
  "1" = "0"
}

eks_security_grp_egress_rule_to_port = {
  "1" = "0"
}

eks_security_grp_egress_rule_self_flag = {
  "1" = "false"
}

#==================<< End of EKS Cluster Security grp engress rule variables. >>================#


#==================<< Start of IAM Policy variables. >>================#

eks_cluster_policies_list          = ["AmazonEKSClusterPolicy", "AmazonEKSServicePolicy"]
eks_node_grp_policies_list         = ["AmazonEKSWorkerNodePolicy", "AmazonEC2ContainerRegistryReadOnly", "AmazonEKS_CNI_Policy", "CloudWatchApplicationInsightsFullAccess", "CloudWatchFullAccess", "AutoScallingFullAccess", "AmazonEKSServicePolicy", "AmazonSSMManagedInstanceCore", "AmazonSSMPatchAssociation"]
#jump_vm_policies_list              = ["AdministratorAccess"]
iam_policies_arn = {
 # "AdministratorAccess"                    = "arn:aws:iam::aws:policy/AdministratorAccess"
  "AmazonEC2ContainerRegistryReadOnly"     = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  "AmazonEKSClusterPolicy"                 = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  "AmazonEKSWorkerNodePolicy"              = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  "AmazonEKS_CNI_Policy"                   = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  "CloudWatchApplicationInsightsFullAccess" = "arn:aws:iam::aws:policy/CloudWatchApplicationInsightsFullAccess"
  "CloudWatchFullAccess"                   = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
  "AdministratorAccess"                    = "arn:aws:iam::aws:policy/AdministratorAccess"
  "AutoScallingFullAccess"                 = "arn:aws:iam::aws:policy/AutoScalingFullAccess"
  "AmazonEKSServicePolicy"                 = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  "AmazonSSMPatchAssociation"              = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
  "AmazonSSMManagedInstanceCore"           = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

#==================<< End of IAM Policy variables. >>================#


#==================<< Start of EKS cluster and EKS Node Group variables. >>================#

eks_suffix                                      = ""
cluster_name                                    = "ado-sbx-app-dev"
eks_version                                     = "1.30"
eks_nodegrp_ami_name                            = "amazon-eks-node-1.30-v20240615"
node_group_name                                 = ["ng1"]
eks_nodegrp_disk_device_name                    = "/dev/xvda"
node_group_disk_size                            = { "ng1" = 64 }
eks_nodegrp_volume_type                         = "gp3"
eks_nodegrp_disk_termination_flag               = true
eks_nodegrp_disk_encryption_flag                = true
eks_nodegrp_ebs_optimized_flag                  = false
eks_launch_template_associate_public_ip_address = false
node_group_instance_types                       = { "ng1" =["t3.medium"] }     
eks_nodegrp_monitoring_flag                     = false
node_group_min_size                             = { "ng1" = 2 }
node_group_desired_size                         = { "ng1" = 2 }
node_group_max_size                             = { "ng1" = 5 }
node_group_labels                               = { "ng1" = {} }

#==================<< End of EKS cluster and EKS Node Group variables. >>================#


#####################################################################################################
#==================<< Start of EKS NodeGroup Security grp ingress rule variables. >>================#

eks_node_security_grp_ingress_rule_no = ["1"]

eks_node_security_grp_ingress_destination_cidr_block = {
  # VPC  CIDR is "10.10.0.0/21"
  "1" = "172.31.0.0/16"
}

eks_node_security_grp_ingress_rule_protocol = {
  "1" = "all"
}

eks_node_security_grp_ingress_rule_from_port = {
  "1" = "0"
}

eks_node_security_grp_ingress_rule_to_port = {
  "1" = "0"
}

eks_node_security_grp_ingress_rule_self_flag = {
  "1" = "false"
}

#==================<< End of EKS NodeGrouop Security grp ingress rule variables. >>================#
#==================<< Start of EKS NodeGroup Security grp engress rule variables. >>================#

eks_node_security_grp_egress_rule_no = ["1"]

eks_node_security_grp_egress_destination_cidr_block = {
  "1" = "0.0.0.0/0"
}

eks_node_security_grp_egress_rule_protocol = {
  "1" = "all"
}

eks_node_security_grp_egress_rule_from_port = {
  "1" = "0"
}

eks_node_security_grp_egress_rule_to_port = {
  "1" = "0"
}

eks_node_security_grp_egress_rule_self_flag = {
  "1" = "false"
}

#==================<< End of EKS NodeGroup Security grp engress rule variables. >>================#
