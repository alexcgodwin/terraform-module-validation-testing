# Infrastructure testing pyramid

## Level 1: syntax and static rules

`terraform fmt -check`, `terraform init -backend=false`, `terraform validate` and `tflint` catch formatting, schema mistakes, unused declarations and common antipatterns. They do not prove a cloud resource can be deployed or behaves correctly.

## Level 2: module contract tests

`terraform test` runs positive and negative HCL tests in `modules/workload-contract/tests`. All `run` blocks use `command = plan`, so they do not apply resources. Four input validation cases are expected to fail and are asserted using `expect_failures`.

## Level 3: real Terraform lifecycle

The optional Go Terratest example uses `InitAndApply`, `Output`, and deferred `Destroy` for a local-only `terraform_data` module. It checks actual output values. No live AWS resource is involved. Because Go dependencies are substantial, this test is separated behind an opt-in manual GitHub Actions dispatch with its own timeout.

## Level 4: cloud integration before production

For real VPC/AKS/EKS or IAM modules, use a dedicated short-lived AWS/Azure test account, ephemeral credentials, quotas and automatic teardown. Assert actual API resources, policy effectiveness, network connectivity and cost cleanup. Never imply this cloud test has run when it has not.

## CI quality gates

- Required: fmt, init and validate, native positive/negative tests, tflint, Python contract assertions.
- Manual: Terratest on `workflow_dispatch` with verified Go and pinned dependency version.
- Production: separate approval for any cloud account integration, with limited scope and budget.
