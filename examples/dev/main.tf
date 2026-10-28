terraform { required_version = ">= 1.7.0" }
module "workload" {
  source       = "../../modules/workload-contract"
  team         = "platform-team"
  environment  = "dev"
  cost_center  = "CC-1001"
  max_replicas = 3
}
output "team" { value = module.workload.team }
output "alert_level" { value = module.workload.alert_level }
output "labels" { value = module.workload.labels }
