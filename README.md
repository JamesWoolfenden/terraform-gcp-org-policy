# terraform-gcp-org-policy

[![Build Status](https://github.com/JamesWoolfenden/terraform-gcp-org-policy/workflows/Verify/badge.svg?branch=main)](https://github.com/JamesWoolfenden/terraform-gcp-org-policy/actions)
[![Latest Release](https://img.shields.io/github/release/JamesWoolfenden/terraform-gcp-org-policy.svg)](https://github.com/JamesWoolfenden/terraform-gcp-org-policy/releases/latest)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/JamesWoolfenden/terraform-gcp-org-policy.svg?label=latest)](https://github.com/JamesWoolfenden/terraform-gcp-org-policy/releases/latest)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D1.5.0-blue.svg)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

Terraform module for Organization Policy (v2 `google_org_policy_policy`). Applies a map of constraints to a project, folder or organization (`projects/x`, `folders/x` or `organizations/x`, validated), each as a boolean `enforce`, list `allow`/`deny` values, or `allow_all`/`deny_all`, with an optional CEL condition (a conditional boolean rule is paired with an unconditional fallback of the opposite enforcement). The default is a security baseline: OS Login required, service account key creation disabled, VM external IPs denied, uniform bucket-level access and public access prevention enforced, default network creation skipped, automatic IAM grants to default service accounts disabled, and Cloud SQL public IPs restricted.

## Usage

Add **module.org-policy.tf** to your code:-

```terraform
module "org_policy" {
  source = "jameswoolfenden/org-policy/gcp"
  parent = "projects/my-project"
}
```

See [example/examplea](example/examplea) for a complete working example. Note that `compute.skipDefaultNetworkCreation` and `iam.automaticIamGrantsForDefaultServiceAccounts` only take effect for projects created after the policy is set, so they are most useful on a folder or organization parent.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [google_org_policy_policy.allow_all](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/org_policy_policy) | resource |
| [google_org_policy_policy.boolean](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/org_policy_policy) | resource |
| [google_org_policy_policy.conditional_boolean](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/org_policy_policy) | resource |
| [google_org_policy_policy.deny_all](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/org_policy_policy) | resource |
| [google_org_policy_policy.values](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/org_policy_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_parent"></a> [parent](#input\_parent) | Resource the policies are attached to: "projects/<project-id-or-number>", "folders/<folder-number>" or "organizations/<org-number>" | `string` | n/a | yes |
| <a name="input_policies"></a> [policies](#input\_policies) | Map of org policy constraint name (without the constraints/ prefix) to its rule: a boolean enforce, or list allow/deny values, or allow\_all/deny\_all, with an optional CEL condition. A conditional boolean rule gets an unconditional fallback rule with the opposite enforcement. The default is a security baseline | `map(object({ enforce = optional(bool), allow = optional(list(string)), deny = optional(list(string)), allow_all = optional(bool), deny_all = optional(bool), condition = optional(object({ expression = string, title = string, description = optional(string) })) }))` | `{ compute.requireOsLogin, iam.disableServiceAccountKeyCreation, compute.vmExternalIpAccess (deny_all), storage.uniformBucketLevelAccess, storage.publicAccessPrevention, compute.skipDefaultNetworkCreation, iam.automaticIamGrantsForDefaultServiceAccounts, sql.restrictPublicIp }` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_parent"></a> [parent](#output\_parent) | Resource the policies are attached to |
| <a name="output_policy_ids"></a> [policy\_ids](#output\_policy\_ids) | Map of constraint name to org policy ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Role and Permissions

<!-- BEGINNING OF PRE-COMMIT-PIKE DOCS HOOK -->
pike has no tested permission mapping for `google_org_policy_policy` yet, so no role is generated for this module.
<!-- END OF PRE-COMMIT-PIKE DOCS HOOK -->

## Help

**Got a question?**

File a GitHub [issue](https://github.com/jameswoolfenden/terraform-gcp-org-policy/issues).

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/jameswoolfenden/terraform-gcp-org-policy/issues) to report any bugs or file feature requests.

## Copyrights

Copyright © 2026 James Woolfenden

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements. See the NOTICE file
distributed with this work for additional information
regarding copyright ownership. The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at

<https://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied. See the License for the
specific language governing permissions and limitations
under the License.

### Contributors

[![James Woolfenden][jameswoolfenden_avatar]][jameswoolfenden_homepage]<br/>[James Woolfenden][jameswoolfenden_homepage]

[jameswoolfenden_homepage]: https://github.com/jameswoolfenden
[jameswoolfenden_avatar]: https://github.com/jameswoolfenden.png?size=150
