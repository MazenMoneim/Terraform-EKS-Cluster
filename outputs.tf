output "cluster_namer" {
  value = module.eks.cluster_name
}

output "cluster_id" {
  value = module.eks.cluster_id
}


output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}


output "node_info" {
  value = module.eks.eks_managed_node_groups
}

output "scalling_configuration" {
  value = module.eks.eks_managed_node_groups_autoscaling_group_names

}

