module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.25.0"
  cluster_name    = var.cluster_name
  cluster_version = "1.30"

  cluster_endpoint_public_access = true
  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  node_security_group_additional_rules = {
    rule_1 = {
      type        = "ingress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  eks_managed_node_groups = {

    one = {
      instance_types = ["t3.small"]
      min_size       = 1
      max_size       = 2
      desired_size   = 1
      tags = {
        eks = "true"
      }
    }

    two = {
      instance_types = ["t3.small"]
      min_size       = 1
      max_size       = 2
      desired_size   = 1
      tags = {
        eks = "true"
      }
    }
    
  }

  tags = local.common_tags
}