output "policy_ids" {
  value = merge(
    { for k, v in google_org_policy_policy.boolean : k => v.id },
    { for k, v in google_org_policy_policy.conditional_boolean : k => v.id },
    { for k, v in google_org_policy_policy.allow_all : k => v.id },
    { for k, v in google_org_policy_policy.deny_all : k => v.id },
    { for k, v in google_org_policy_policy.values : k => v.id },
  )
  description = "Map of constraint name to org policy ID"
}

output "parent" {
  value       = var.parent
  description = "Resource the policies are attached to"
}
