variable "parent" {
  type        = string
  description = "Resource the policies are attached to: \"projects/{project-id-or-number}\", \"folders/{folder-number}\" or \"organizations/{org-number}\""

  validation {
    condition     = can(regex("^(projects/[a-z0-9-]{6,30}|folders/[0-9]+|organizations/[0-9]+)$", var.parent))
    error_message = "var.parent must be projects/<project-id-or-number>, folders/<folder-number> or organizations/<org-number>"
  }
}

variable "policies" {
  type = map(object({
    enforce   = optional(bool)
    allow     = optional(list(string))
    deny      = optional(list(string))
    allow_all = optional(bool, false)
    deny_all  = optional(bool, false)
    condition = optional(object({
      expression  = string
      title       = string
      description = optional(string)
    }))
  }))
  description = "Map of org policy constraint name (without the constraints/ prefix) to its rule: a boolean enforce, or list allow/deny values, or allow_all/deny_all, with an optional CEL condition. A conditional boolean rule gets an unconditional fallback rule with the opposite enforcement. The default is a security baseline"
  default = {
    "compute.requireOsLogin"                          = { enforce = true }
    "iam.disableServiceAccountKeyCreation"            = { enforce = true }
    "compute.vmExternalIpAccess"                      = { deny_all = true }
    "storage.uniformBucketLevelAccess"                = { enforce = true }
    "storage.publicAccessPrevention"                  = { enforce = true }
    "compute.skipDefaultNetworkCreation"              = { enforce = true }
    "iam.automaticIamGrantsForDefaultServiceAccounts" = { enforce = true }
    "sql.restrictPublicIp"                            = { enforce = true }
  }

  validation {
    condition     = length(var.policies) > 0
    error_message = "var.policies must define at least one policy"
  }

  validation {
    condition     = alltrue([for k, v in var.policies : can(regex("^[a-zA-Z0-9]+\\.[a-zA-Z0-9.]+$", k))])
    error_message = "var.policies keys must be constraint names such as compute.requireOsLogin, without the constraints/ prefix"
  }

  validation {
    condition = alltrue([
      for k, v in var.policies : length([for set in [v.enforce != null, v.allow != null || v.deny != null, v.allow_all, v.deny_all] : set if set]) == 1
    ])
    error_message = "Each policy must set exactly one of: enforce, allow/deny values, allow_all or deny_all"
  }

  validation {
    condition = alltrue([
      for k, v in var.policies : v.condition == null || (length(trimspace(v.condition.expression)) > 0 && length(trimspace(v.condition.title)) > 0)
    ])
    error_message = "A policy condition must have a non-empty expression and title"
  }

  validation {
    condition = alltrue(flatten([
      for k, v in var.policies : [for val in concat(coalesce(v.allow, []), coalesce(v.deny, [])) : length(trimspace(val)) > 0]
    ]))
    error_message = "Policy allow/deny values must be non-empty strings"
  }
}
