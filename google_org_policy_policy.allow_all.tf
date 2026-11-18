resource "google_org_policy_policy" "allow_all" {
  for_each = local.allow_all_policies

  name   = "${var.parent}/policies/${each.key}"
  parent = var.parent

  spec {
    rules {
      allow_all = "TRUE"

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
