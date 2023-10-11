module "network" {
  source = "git@github.com:ccscshq/terraform-aws-network.git?ref=v0.1.0"

  prefix                 = local.prefix
  ipv4_cidr              = local.ipv4_cidr
  ipv4_cidr_newbits      = local.ipv4_cidr_newbits
  subnets_number         = local.subnets_number
  create_private_subnets = true
}

module "ecs" {
  source = "git@github.com:ccscshq/terraform-aws-backend-ecs.git?ref=v0.2.1"

  prefix = local.prefix
  # acm
  hosted_zone_domain = "example.com"
  api_domain         = "api.example.com"
  # ecs
  ecs_cluster_name             = "test"
  ecs_service_name             = "api"
  ecs_container_image          = "container_image"
  ecs_container_port           = 8080
  ecs_desired_count            = 2
  ecs_autoscaling_max_capacity = 10
  ecs_autoscaling_min_capacity = 2
  ecs_environment              = []
  ecs_task_policy_arns         = []
  ecs_cpu_architecture         = "X86_64"
  enable_ecs_exec              = true
  # lb
  lb_healthcheck_interval            = 30
  lb_healthcheck_path                = "/health"
  lb_healthcheck_timeout             = 3
  lb_healthcheck_healthy_threshold   = 2
  lb_healthcheck_unhealthy_threshold = 5
  lb_healthcheck_matcher             = "200-204"
  lb_delete_protection               = false
  # network
  vpc_id             = module.network.vpc_id
  public_subnet_ids  = module.network.public_subnet_ids
  private_subnet_ids = module.network.private_subnet_ids
}


module "cicd" {
  source = "../../"

  prefix                  = local.prefix
  github_repository_owner = "ccscshq"
  github_repository       = "spring-boot-example"
  github_branch           = "main"
  ecs_cluster_name        = module.ecs.ecs_cluster_name
  ecs_service_name        = module.ecs.ecs_service_name
  s3_bucket_force_destroy = true
}
