resource "google_org_policy_policy" "deny_all" {
  for_each = local.deny_all_policies

  name   = "${var.parent}/policies/${each.key}"
  parent = var.parent

  spec {
    rules {
      deny_all = "TRUE"

      dynamic "condition" {
        for_each = each.value.condition == null ? [] : [each.value.condition]
        content {
          expression  = condition.value.expression
          title       = condition.value.title
          description = condition.value.description
        }
      }
    }
  }
}
