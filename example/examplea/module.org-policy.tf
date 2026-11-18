# holden:ignore:HLD_TF_026 — examples intentionally use ../../ to reference the local module root
module "org_policy" {
  source = "../../"
  parent = "projects/${data.google_project.current.project_id}"
}
