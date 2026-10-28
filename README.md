# Terraform Module Validation and Testing

[![Module Validation CI](https://github.com/alexcgodwin/terraform-module-validation-testing/actions/workflows/ci.yml/badge.svg)](https://github.com/alexcgodwin/terraform-module-validation-testing/actions/workflows/ci.yml)

Build, validate and test a reusable Terraform module against an explicit workload contract. The test matrix covers Terraform schema checks, positive and negative variable validation, native `.tftest.hcl` tests, TFLint rules, and an optional Go Terratest lifecycle test.

## Quality gates

| Layer | Implementation | Cloud cost |
| --- | --- | --- |
| Formatting and schema | `terraform fmt`, `terraform validate` | None |
| Invalid inputs | Four `expect_failures` native tests | None |
| Expected behavior | Two positive native tests | None |
| Linter | TFLint rules | None |
| Runtime Terraform contract | Terratest apply/output/destroy of `terraform_data` | None |
| Live cloud integration | Deliberately not included | Requires separate approval |

## Run the required tests

```bash
terraform -chdir=modules/workload-contract init -backend=false
terraform -chdir=modules/workload-contract validate
terraform -chdir=modules/workload-contract test
python -m unittest discover -s tests -v
```

TFLint installation is handled by GitHub Actions; use `tflint --init` and `tflint --chdir modules/workload-contract` locally. For Terratest, install Go and run `cd terratest && go mod tidy && go test -v -timeout 12m ./...`. Terratest is opt-in on a manually dispatched workflow because it downloads a larger dependency tree.

Read [Test Strategy](docs/TEST_STRATEGY.md) and [TFLint policy](docs/TFLINT.md). This repository is a cloud-free reference and does not claim any real production AWS/Azure deployments.
