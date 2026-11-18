# A conditional boolean rule must be paired with an unconditional rule that
# applies everywhere else, so the second rule takes the opposite enforcement.
resource "google_org_policy_policy" "conditional_boolean" {
  for_each = local.conditional_boolean_policies

  name   = "${var.parent}/policies/${each.key}"
  parent = var.parent

  spec {
    rules {
      enforce = each.value.enforce ? "TRUE" : "FALSE"

      condition {
        expression  = each.value.condition.expression
        title       = each.value.condition.title
        description = each.value.condition.description
      }
    }

    rules {
      enforce = each.value.enforce ? "FALSE" : "TRUE"
    }
  }
}
