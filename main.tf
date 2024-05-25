###======= Create key_pair to access the instance =====##
resource "aws_key_pair" "group_3_key" {

  key_name   = "group_3_key"
  public_key = var.pub_key

}

module "vpc" {

  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"
  name = var.vpc_name
  cidr = var.vpc_cidr
  create_igw = true
  enable_nat_gateway = true
  azs             = var.a_zones
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  map_public_ip_on_launch = true

}


module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"
  cluster_name    = var.cluster_name
  cluster_version = "1.29"
  cluster_endpoint_public_access  = true
  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.public_subnets
  control_plane_subnet_ids = module.vpc.public_subnets

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }



  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t3.large"]
    attach_cluster_primary_security_group = true
  }
  
  eks_managed_node_groups = {

    node_group = {
        
      min_size     = 1
      max_size     = 3
      desired_size = 1
      key_name = "group_3_key"
      capacity_type = "SPOT"
      instance_types = ["t3.large"]
      
    }
  }

  access_entries = {
    # One access entry with a policy associated
    example = {
      kubernetes_groups = []
      principal_arn     = "arn:aws:iam::564207976730:user/group3"

       policy_associations = {
        example = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
          access_scope = {
            namespaces = []
            type       = "cluster"
          }
        }
      }

      policy_associations = {
        example = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
          access_scope = {
            namespaces = []
            type       = "cluster"
          }
        }
      }
    }
  }


  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
    
}

