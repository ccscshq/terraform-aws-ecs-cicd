variable "prefix" {
  description = "Name prefix for resources."
  type        = string
}
variable "github_repository_owner" {
  description = "Name of GitHub repository owner."
  type        = string
}
variable "github_repository" {
  description = "Name of GitHub repository."
  type        = string
}
variable "github_branch" {
  description = "Name of source branch."
  type        = string
  default     = "main"
}
variable "ecs_cluster_name" {
  description = "Name of the ECS cluster."
  type        = string
}
variable "ecs_service_name" {
  description = "Name of the ECS service."
  type        = string
}
variable "s3_bucket_force_destroy" {
  description = "Whether to forcibly delete the S3 bucket."
  type        = bool
  default     = false
}
