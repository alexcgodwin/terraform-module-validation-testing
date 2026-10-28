run "reject_invalid_team" {
  command = plan
  variables {
    team        = "BAD TEAM"
    environment = "dev"
    cost_center = "CC-1001"
  }
  expect_failures = [var.team]
}
run "reject_unknown_environment" {
  command = plan
  variables {
    team        = "platform"
    environment = "production"
    cost_center = "CC-1001"
  }
  expect_failures = [var.environment]
}
run "reject_excessive_replicas" {
  command = plan
  variables {
    team         = "platform"
    environment  = "dev"
    cost_center  = "CC-1001"
    max_replicas = 100
  }
  expect_failures = [var.max_replicas]
}
run "reject_unknown_cost_center" {
  command = plan
  variables {
    team        = "platform"
    environment = "dev"
    cost_center = "finance"
  }
  expect_failures = [var.cost_center]
}
