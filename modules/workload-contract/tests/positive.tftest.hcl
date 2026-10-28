run "production_uses_critical_alerts" {
  command = plan
  variables {
    team         = "payments"
    environment  = "prod"
    cost_center  = "CC-4123"
    max_replicas = 12
  }
  assert {
    condition     = output.alert_level == "critical"
    error_message = "Production must use critical alerting."
  }
  assert {
    condition     = output.labels.cost_center == "CC-4123"
    error_message = "Cost attribution label missing."
  }
}
run "development_uses_warning_alerts" {
  command = plan
  variables {
    team        = "platform"
    environment = "dev"
    cost_center = "CC-4001"
  }
  assert {
    condition     = output.alert_level == "warning"
    error_message = "Development should use warning alerts."
  }
}
