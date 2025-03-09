terraform {
  required_providers {

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.35.1"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.17.0"
    }

  }

}

# With Kubeconfig
provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "arn:aws:eks:us-east-1:308898168168:cluster/my-cluster"
}

provider "kubectl" {
  config_path    = "~/.kube/config"
  config_context = "arn:aws:eks:us-east-1:308898168168:cluster/my-cluster"
}

provider "helm" {
  debug = true
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "arn:aws:eks:us-east-1:308898168168:cluster/my-cluster"
  }
}

# Without kubeconfig, you need to have a
# remote / shared terraform tfstate backend to reference data.aws_eks_cluster object 

# provider "kubernetes" {
#   host                   = data.aws_eks_cluster.cluster.endpoint
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
#   token                  = data.aws_eks_cluster_auth.cluster.token
# }
# 
# provider "kubectl" {
#   host  = data.aws_eks_cluster.cluster.endpoint
#   token = data.aws_eks_cluster_auth.cluster.token
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
#   load_config_file = false
# }
# 
# provider "helm" {
#   debug = true
#   kubernetes {
#     host = data.aws_eks_cluster.cluster.endpoint
#     cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
#     token = data.aws_eks_cluster_auth.cluster.token
#   }
# }