variable "vpc_id" {
  type = string
}

variable "private_subnet_1_id" {
  type = string
}

variable "private_subnet_2_id" {
  type = string
}

variable "private_subnet_3_id" {
  type = string
}

variable "environment" {
  type = string
}

variable "domain" {
  type = string
}


#==================<< Start of the common variables. >>================#
variable "aws_auth_profile" {
  type        = string
  default     = "default"
  description = "AWS Auth profile name"
}

variable "resource_region" {
  type        = string
  description = "Region in which you want to create resources"
}

variable "region" {
  type = string
}

variable "project" {
  type = string
}

variable "env" {
  type = string
}

variable "global_suffix" {
  type    = string
  default = ""
}

variable "resource_azs" {
  type = list(string)
}

variable "resource_azs_name" {
  type = map(string)
}

variable "default_tags" {
  description = "Default set of tags to apply to AWS resources"
  type        = map(string)
}

#==================<< End of the common variables. >>================#



#==================<< Start of EKS Cluster Security grp ingress rule variables. >>================#

variable "eks_security_grp_ingress_rule_no" {
  type = list(string)
}

variable "eks_security_grp_ingress_destination_cidr_block" {
  type = map(string)
}

variable "eks_security_grp_ingress_rule_protocol" {
  type = map(string)
}

variable "eks_security_grp_ingress_rule_from_port" {
  type = map(string)
}

variable "eks_security_grp_ingress_rule_to_port" {
  type = map(string)
}

variable "eks_security_grp_ingress_rule_self_flag" {
  type = map(string)
}

#==================<< End of EKS Cluster Security grp ingress rule variables. >>================#

#==================<< Start of EKS Cluster Security grp engress rule variables. >>================#

variable "eks_security_grp_egress_rule_no" {
  type    = list(string)
  default = ["1"]
}

variable "eks_security_grp_egress_destination_cidr_block" {
  type = map(any)
  default = {
    "1" = "0.0.0.0/0"
  }
}

variable "eks_security_grp_egress_rule_protocol" {
  type = map(string)
  default = {
    "1" = "all"
  }
}

variable "eks_security_grp_egress_rule_from_port" {
  type = map(string)
  default = {
    "1" = "0"
  }
}

variable "eks_security_grp_egress_rule_to_port" {
  type = map(string)
  default = {
    "1" = "0"
  }
}

variable "eks_security_grp_egress_rule_self_flag" {
  type = map(string)
  default = {
    "1" = "false"
  }
}

#==================<< End of EKS Cluster Security grp engress rule variables. >>================#


#==================<< Start of IAM Policy variables. >>================#

variable "iam_policies_list" {
  type    = list(string)
  default = ["AmazonEKSClusterPolicy", "AmazonEKSWorkerNodePolicy", "AmazonEC2ContainerRegistryReadOnly", "AmazonEKS_CNI_Policy", "AdministratorAccess", "Role-USEast2-SRE-Prod-JumpVM", "Policy-S3-ListAllBuckets", "Policy-EastUS-SRE-PROD-EKS"]
}

variable "iam_policies_arn" {
  type = map(string)
  default = {
    "AmazonEKSClusterPolicy"             = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    "AmazonEKSWorkerNodePolicy"          = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    "AmazonEC2ContainerRegistryReadOnly" = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    "AmazonEKS_CNI_Policy"               = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    "AdministratorAccess"                = "arn:aws:iam::aws:policy/AdministratorAccess"
    "Policy-S3-ListAllBuckets"           = "arn:aws:iam::020560682473:policy/Policy-S3-ListAllBuckets"
    "Policy-EastUS-SRE-PROD-EKS"         = "arn:aws:iam::020560682473:policy/Policy-EastUS-SRE-PROD-EKS"
  }
}

#==================<< End of IAM Policy variables. >>================#

#==================<< Start of EKS cluster IAM Policy variables. >>================#

variable "eks_cluster_policies_list" {
  type    = list(string)
  default = ["AmazonEKSClusterPolicy"]
}

variable "eks_node_grp_policies_list" {
  type    = list(string)
  default = ["AmazonEKSWorkerNodePolicy", "AmazonEC2ContainerRegistryReadOnly", "AmazonEKS_CNI_Policy"]
}

variable "jump_vm_policies_list" {
  type    = list(string)
  default = ["AdministratorAccess"]
}

#==================<< End of EKS cluster IAM Policy variables. >>================#

#==================<< Start of EKS cluster and EKS Node Group variables. >>================#

variable "eks_version" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "eks_suffix" {
  default = ""
}

variable "eks_nodegrp_ami_name" {
  default = "amazon-eks-node-1.19-v20210526"
}

variable "node_group_name" {
  type = list(string)
}

variable "eks_nodegrp_disk_device_name" {
  type    = string
  default = "/dev/xvda"
}

variable "node_group_disk_size" {
  type = map(string)
}

variable "eks_nodegrp_volume_type" {
  type    = string
  default = "gp3"
}

variable "eks_nodegrp_disk_termination_flag" {
  type    = bool
  default = true
}

variable "eks_launch_template_associate_public_ip_address" {
  type    = bool
  default = false
}

variable "eks_nodegrp_disk_encryption_flag" {
  type    = bool
  default = true
}

variable "node_group_instance_types" {
  type = map(list(string))
}

variable "eks_nodegrp_monitoring_flag" {
  type    = bool
  default = false
}

variable "node_group_desired_size" {
  type = map(string)
}

variable "node_group_max_size" {
  type = map(string)
}

variable "node_group_min_size" {
  type = map(string)
}

variable "eks_nodegrp_ebs_optimized_flag" {
  type    = bool
  default = false
}

variable "node_group_labels" {
  type    = any
  default = false
}


#==================<< End of EKS cluster and EKS Node Group variables. >>================#


#####################################################################################################
#==================<< Start of EKS NodeGroup Security grp ingress rule variables. >>================#

variable "eks_node_security_grp_ingress_rule_no" {
  type = list(string)
}

variable "eks_node_security_grp_ingress_destination_cidr_block" {
  type = map(string)
}

variable "eks_node_security_grp_ingress_rule_protocol" {
  type = map(string)
}

variable "eks_node_security_grp_ingress_rule_from_port" {
  type = map(string)
}

variable "eks_node_security_grp_ingress_rule_to_port" {
  type = map(string)
}

variable "eks_node_security_grp_ingress_rule_self_flag" {
  type = map(string)
}

#==================<< End of EKS NodeGroup Security grp ingress rule variables. >>================#

#==================<< Start of EKS NodeGroup Security grp engress rule variables. >>================#

variable "eks_node_security_grp_egress_rule_no" {
  type    = list(string)
  default = ["1"]
}

variable "eks_node_security_grp_egress_destination_cidr_block" {
  type = map(any)
  default = {
    "1" = "0.0.0.0/0"
  }
}

variable "eks_node_security_grp_egress_rule_protocol" {
  type = map(string)
  default = {
    "1" = "all"
  }
}

variable "eks_node_security_grp_egress_rule_from_port" {
  type = map(string)
  default = {
    "1" = "0"
  }
}

variable "eks_node_security_grp_egress_rule_to_port" {
  type = map(string)
  default = {
    "1" = "0"
  }
}

variable "eks_node_security_grp_egress_rule_self_flag" {
  type = map(string)
  default = {
    "1" = "false"
  }
}

#==================<< End of EKS NodeGroup Security grp engress rule variables. >>================#



