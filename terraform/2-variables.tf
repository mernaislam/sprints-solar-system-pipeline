variable "node_groups" {
  description   = "EKS node groups configuration"
  type          = map(object({
    instance_types = list(string)
    capacity_type  = string
    scaling_config = object({
      desired_size = number
      max_size     = number
      min_size     = number 
    })
  }))

  default = {
    "default" = {
      instance_types = ["t3.small"]
      capacity_type  = "ON_DEMAND"
      scaling_config = {
        desired_size = 3
        max_size     = 5
        min_size     = 2
      }
    }
  }
}