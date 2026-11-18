resource "google_org_policy_policy" "values" {
  for_each = local.value_policies

  name   = "${var.parent}/policies/${each.key}"
  parent = var.parent

  spec {
    rules {
      values {
        allowed_values = each.value.allow
        denied_values  = each.value.deny
      }

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
