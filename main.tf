## Creating the local variables
locals {
  resource_common_naming = format("%s-%s-%s", var.project, var.region, var.env)
  resource_name_prefix   = format("%s-%s", var.project, var.env)

  default_tags = var.default_tags
}


## EKS-Cluster Security Groups
## https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "eks_security_grp" {
  name   = format("%sEKS-Cluster-SecurityGrp%s", local.resource_name_prefix, var.global_suffix)
  vpc_id = var.vpc_id
  tags   = tomap({ Name = format("%sEKS-Cluster-SecurityGrp%s", local.resource_name_prefix, var.global_suffix) })
}

## EKS-Cluster Security Group rules
## https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule
resource "aws_security_group_rule" "eks_ingress_security_grp_self_rule" {
  type              = "ingress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "all"
  self              = true
  security_group_id = aws_security_group.eks_security_grp.id
}

resource "aws_security_group_rule" "eks_ingress_security_grp_rule" {
  count       = length(var.eks_security_grp_ingress_rule_no)
  type        = "ingress"
  from_port   = var.eks_security_grp_ingress_rule_from_port[element(var.eks_security_grp_ingress_rule_no, count.index)]
  to_port     = var.eks_security_grp_ingress_rule_to_port[element(var.eks_security_grp_ingress_rule_no, count.index)]
  protocol    = var.eks_security_grp_ingress_rule_protocol[element(var.eks_security_grp_ingress_rule_no, count.index)]
  cidr_blocks = [var.eks_security_grp_ingress_destination_cidr_block[element(var.eks_security_grp_ingress_rule_no, count.index)]]
  #self              = var.eks_security_grp_ingress_rule_self_flag[element(var.eks_security_grp_ingress_rule_no, count.index)]
  security_group_id = aws_security_group.eks_security_grp.id
}

resource "aws_security_group_rule" "eks_egress_security_grp_rule" {
  count       = length(var.eks_security_grp_egress_rule_no)
  type        = "egress"
  from_port   = var.eks_security_grp_egress_rule_from_port[element(var.eks_security_grp_egress_rule_no, count.index)]
  to_port     = var.eks_security_grp_egress_rule_to_port[element(var.eks_security_grp_egress_rule_no, count.index)]
  protocol    = var.eks_security_grp_egress_rule_protocol[element(var.eks_security_grp_egress_rule_no, count.index)]
  cidr_blocks = [var.eks_security_grp_egress_destination_cidr_block[element(var.eks_security_grp_egress_rule_no, count.index)]]
  #self              = var.eks_security_grp_egress_rule_self_flag[element(var.eks_security_grp_egress_rule_no, count.index)]
  security_group_id = aws_security_group.eks_security_grp.id
}

###############################################################################################
## EKS-NodeGroup Security Groups
## https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "eks_node_security_grp" {
  name   = format("%sEKS-Nodegroup-SecurityGrp%s", local.resource_name_prefix, var.global_suffix)
  vpc_id = var.vpc_id
  tags   = tomap({Name = format("%sEKS-Nodegroup-SecurityGrp%s", local.resource_name_prefix, var.global_suffix)})
}


## EKS-NodeGroup Security Group rules
## https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule
resource "aws_security_group_rule" "eks_node_ingress_security_grp_self_rule" {
  type              = "ingress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "all"
  self              = true
  security_group_id = aws_security_group.eks_node_security_grp.id
}

resource "aws_security_group_rule" "eks_node_ingress_security_grp_rule" {
  count       = length(var.eks_node_security_grp_ingress_rule_no)
  type        = "ingress"
  from_port   = var.eks_node_security_grp_ingress_rule_from_port[element(var.eks_security_grp_ingress_rule_no, count.index)]
  to_port     = var.eks_node_security_grp_ingress_rule_to_port[element(var.eks_security_grp_ingress_rule_no, count.index)]
  protocol    = var.eks_node_security_grp_ingress_rule_protocol[element(var.eks_security_grp_ingress_rule_no, count.index)]
  cidr_blocks = [var.eks_node_security_grp_ingress_destination_cidr_block[element(var.eks_security_grp_ingress_rule_no, count.index)]]
  security_group_id = aws_security_group.eks_node_security_grp.id
}

resource "aws_security_group_rule" "eks_node_egress_security_grp_rule" {
  count       = length(var.eks_node_security_grp_egress_rule_no)
  type        = "egress"
  from_port   = var.eks_node_security_grp_egress_rule_from_port[element(var.eks_security_grp_egress_rule_no, count.index)]
  to_port     = var.eks_node_security_grp_egress_rule_to_port[element(var.eks_security_grp_egress_rule_no, count.index)]
  protocol    = var.eks_node_security_grp_egress_rule_protocol[element(var.eks_security_grp_egress_rule_no, count.index)]
  cidr_blocks = [var.eks_node_security_grp_egress_destination_cidr_block[element(var.eks_security_grp_egress_rule_no, count.index)]]
  security_group_id = aws_security_group.eks_node_security_grp.id
}
#####################################################################################################
#####################################################################################################


## eks Master IAM Role
data "aws_iam_policy_document" "eks_cluster_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

## eks Master IAM Role
data "aws_iam_policy_document" "ec2_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

## IAM Role
## Link: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
resource "aws_iam_role" "eks_cluster_role" {
  name               = format("%sEksClusterRole%s", local.resource_name_prefix, var.global_suffix)
  assume_role_policy = data.aws_iam_policy_document.eks_cluster_assume_role_policy.json
  tags               = tomap({ Name = format("%sEksClusterRole%s", local.resource_name_prefix, var.global_suffix) })
}

## IAM Role Policy attachment
## https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "eks_cluster_role_policy_attachment" {
  count      = length(var.eks_cluster_policies_list)
  policy_arn = var.iam_policies_arn[element(var.eks_cluster_policies_list, count.index)]
  role       = aws_iam_role.eks_cluster_role.name
}

## IAM Role
## Link: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
resource "aws_iam_role" "eks_node_grp_role" {
  name               = format("%sEksNodeGrpRole%s", local.resource_name_prefix, var.global_suffix)
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json
  tags               = tomap({ Name = format("%sEksNodeGrpRole%s", local.resource_name_prefix, var.global_suffix) })
}

## IAM Role Policy attachment
## https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "eks_node_grp_role_policy_attachment" {
  count      = length(var.eks_node_grp_policies_list)
  policy_arn = var.iam_policies_arn[element(var.eks_node_grp_policies_list, count.index)]
  role       = aws_iam_role.eks_node_grp_role.name
}

resource "aws_iam_role_policy_attachment" "eks_node_grp_ecr_policy_attachment" {
  policy_arn = aws_iam_policy.ecr_access_role_policy.arn
  role       = aws_iam_role.eks_node_grp_role.name
}

resource "aws_iam_policy" "ecr_access_role_policy" {
  name        = format("%sEcraccessPolicy%s", local.resource_name_prefix, var.global_suffix)
  path        = "/"
  description = format("%sEcraccessPolicy%s", local.resource_name_prefix, var.global_suffix)
  policy      = data.aws_iam_policy_document.ecr_access_role_policy_data.json
}


data "aws_iam_policy_document" "ecr_access_role_policy_data" {
  version = "2012-10-17"
  statement {
    sid    = "VisualEditor0"
    effect = "Allow"
    actions = [
      "ecr:ListTagsForResource",
      "ecr:ListImages",
      "ecr:DescribeRepositories",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetLifecyclePolicy",
      "ecr:DescribeImageScanFindings",
      "ecr:GetLifecyclePolicyPreview",
      "ecr:BatchGetImage",
      "ecr:DescribeImages",
      "ecr:StartLifecyclePolicyPreview",
      "ecr:InitiateLayerUpload",
      "ecr:GetRepositoryPolicy"
    ]
    resources = ["*"]
  }
}

resource "aws_eks_cluster" "sbx_eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = var.eks_version
  vpc_config {
    subnet_ids         = [var.private_subnet_1_id, var.private_subnet_2_id, var.private_subnet_3_id]
    security_group_ids = [aws_security_group.eks_security_grp.id]

    endpoint_private_access = "true"
    endpoint_public_access  = "false"
  }
  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_role_policy_attachment,
    aws_cloudwatch_log_group.eks_cluster_log_group
    #  aws_iam_role_policy_attachment.example-AmazonEKSVPCResourceController,
  ]

  # depends_on = [aws_cloudwatch_log_group.eks_cluster_log_group]

  enabled_cluster_log_types = ["api", "audit"]
  tags = merge(local.default_tags, {
    Name = format("%s-EksCluster%s", local.resource_name_prefix, var.global_suffix)
  })
}

resource "aws_cloudwatch_log_group" "eks_cluster_log_group" {
  # The log group name format is /aws/eks/<cluster-name>/cluster
  # Reference: https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = 7

}

## Find the EKS Node Group AMI ID based on the AMI Name
## This is highly useful as you don't have to manage the the AMI Id which is different acros region
data "aws_ami" "eks_nodegroup_ami" {

  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
  filter {
    name   = "name"
    values = [var.eks_nodegrp_ami_name]
  }
}

data "aws_ssm_parameter" "eks_ami_release_version" {
  name = "/aws/service/eks/optimized-ami/${aws_eks_cluster.sbx_eks_cluster.version}/amazon-linux-2/recommended/release_version"
}


#################################################################################

resource "aws_launch_template" "eks_nodes_launch_template" {
  count = length(var.node_group_name)
  name  = format("%sEksNodeLaunchTemplate%s%s", local.resource_name_prefix, element(var.node_group_name, count.index), var.global_suffix)
  block_device_mappings {
    device_name = var.eks_nodegrp_disk_device_name
    ebs {
      volume_size           = var.node_group_disk_size[element(var.node_group_name, count.index)]
      volume_type           = var.eks_nodegrp_volume_type
      delete_on_termination = var.eks_nodegrp_disk_termination_flag
      encrypted             = var.eks_nodegrp_disk_encryption_flag
    }
  }

  image_id = data.aws_ami.eks_nodegroup_ami.id
 user_data = base64encode(templatefile("eks-launch-template-user-data.tmpl", {
    eks_cluster_name         = var.cluster_name
  }))
  instance_type          = element(var.node_group_instance_types[element(var.node_group_name, count.index)], 0)
#  vpc_security_group_ids = [aws_security_group.eks_security_grp.id, aws_security_group.eks_node_security_grp.id]
  vpc_security_group_ids = [aws_security_group.eks_node_security_grp.id]
  ebs_optimized          = var.eks_nodegrp_ebs_optimized_flag
  monitoring {
    enabled = var.eks_nodegrp_monitoring_flag
  }

  tag_specifications {
    resource_type = "instance"
    tags = merge(local.default_tags, {
      Name = format("%s-EKS-Node%s", local.resource_name_prefix, var.global_suffix)
    })
  }

  tag_specifications {
    resource_type = "volume"
    tags = merge(local.default_tags, {
      Name = format("%s-EKS-Volume%s", local.resource_name_prefix, var.global_suffix)
    })
  }

  tags = merge(local.default_tags, {
    Name = format("%s-EksNodeLaunchTemplate%s", local.resource_name_prefix, var.global_suffix)
  })
}

######################################################################################
######################################################################################

## eks Node Group
## https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group

resource "aws_eks_node_group" "eks_node_group" {
  count           = length(var.node_group_name)
  cluster_name    = var.cluster_name
  node_group_name = format("%sEks%s%s", local.resource_name_prefix, element(var.node_group_name, count.index), var.global_suffix)
  node_role_arn   = aws_iam_role.eks_node_grp_role.arn
  subnet_ids      = [var.private_subnet_1_id, var.private_subnet_2_id, var.private_subnet_3_id]

  launch_template {
    name    = aws_launch_template.eks_nodes_launch_template[count.index].name
    version = aws_launch_template.eks_nodes_launch_template[count.index].latest_version
  }
  scaling_config {
    desired_size = var.node_group_desired_size[element(var.node_group_name, count.index)]
    min_size     = var.node_group_min_size[element(var.node_group_name, count.index)]
    max_size     = var.node_group_max_size[element(var.node_group_name, count.index)]
  }

  labels = var.node_group_labels[element(var.node_group_name, count.index)]


  # Allow external changes without Terraform plan difference
  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  depends_on = [
    aws_iam_role.eks_node_grp_role,
    aws_iam_role_policy_attachment.eks_node_grp_role_policy_attachment,
    aws_eks_cluster.sbx_eks_cluster
  ]

    tags = merge(local.default_tags, {
    Name = format("%s-EksNodeGroup%s", local.resource_name_prefix, var.global_suffix)
  })
}

