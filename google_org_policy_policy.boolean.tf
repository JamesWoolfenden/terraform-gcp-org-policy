resource "google_org_policy_policy" "boolean" {
  for_each = local.boolean_policies

  name   = "${var.parent}/policies/${each.key}"
  parent = var.parent

  spec {
    rules {
      enforce = each.value.enforce ? "TRUE" : "FALSE"
    }
  }
}
