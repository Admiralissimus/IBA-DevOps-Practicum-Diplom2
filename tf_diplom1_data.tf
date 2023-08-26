data "terraform_remote_state" "kubernetes_cluster" {
  backend = "s3"
  config = {
    bucket = "ushakou-diplom"
    key    = "diplom1/state.tfstate"
    region = "us-east-1"
  }
}

output "cluster_name" {
  value = data.terraform_remote_state.kubernetes_cluster.outputs.cluster_name
}

output "cluster_region" {
  value = data.terraform_remote_state.kubernetes_cluster.outputs.region
}

output "ecr_id" {
  value = data.terraform_remote_state.kubernetes_cluster.outputs.ecr_id
}

output "ecr_url" {
  value = data.terraform_remote_state.kubernetes_cluster.outputs.ecr_url
}
