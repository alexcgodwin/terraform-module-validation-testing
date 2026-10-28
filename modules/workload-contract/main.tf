terraform { required_version = ">= 1.7.0" }
variable "team" {
  type = string
  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{2,24}$", var.team))
    error_message = "team must be 3-25 lowercase DNS-compatible characters."
  }
}
variable "environment" {
  type = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be dev, staging or prod."
  }
}
variable "cost_center" {
  type = string
  validation {
    condition     = can(regex("^CC-[0-9]{4}$", var.cost_center))
    error_message = "cost_center must match CC-1234."
  }
}
variable "max_replicas" {
  type    = number
  default = 3
  validation {
    condition     = var.max_replicas >= 1 && var.max_replicas <= 20 && floor(var.max_replicas) == var.max_replicas
    error_message = "max_replicas must be an integer between 1 and 20."
  }
}
locals {
  labels = {
    team        = var.team
    environment = var.environment
    cost_center = var.cost_center
    managed_by  = "terraform"
  }
}
resource "terraform_data" "contract" {
  input = {
    labels       = local.labels
    max_replicas = var.max_replicas
    alert_level  = var.environment == "prod" ? "critical" : "warning"
  }
}
output "labels" { value = local.labels }
output "team" { value = var.team }
output "alert_level" { value = var.environment == "prod" ? "critical" : "warning" }
output "workload_contract" { value = terraform_data.contract.output }
