# Terraform linter policy

TFLint is a static analysis tool, not a runtime verifier. The root `.tflint.hcl` config enables common Terraform language rules. CI runs it with a pinned setup action against the module directory. Terraform `validate` is a separate required gate.

For a provider-specific AWS/Azure module, add the corresponding TFLint plugin only after pinning the release and verifying plugin supply-chain origin. Do not auto-download unapproved plugins in production pipelines. Log lint exceptions in a change request rather than disabling broad rule categories.
