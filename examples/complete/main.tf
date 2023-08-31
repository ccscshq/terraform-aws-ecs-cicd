module "cicd" {
  source = "../../"

  prefix                  = local.prefix
  github_repository_owner = "ccscshq"
  github_repository       = "spring-boot-example"
  github_branch           = "main"
  ecs_cluster_name        = "friendly-prefix-ccscshq"
  ecs_service_name        = "api"
  s3_bucket_force_destroy = true
}
