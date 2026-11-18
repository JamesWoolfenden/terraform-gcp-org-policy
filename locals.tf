locals {
  # Partition var.policies by rule kind so each google_org_policy_policy
  # resource carries one static rule shape instead of nested dynamic logic.
  boolean_policies             = { for k, v in var.policies : k => v if v.enforce != null && v.condition == null }
  conditional_boolean_policies = { for k, v in var.policies : k => v if v.enforce != null && v.condition != null }
  allow_all_policies           = { for k, v in var.policies : k => v if v.allow_all }
  deny_all_policies            = { for k, v in var.policies : k => v if v.deny_all }
  value_policies               = { for k, v in var.policies : k => v if v.allow != null || v.deny != null }
}
