resource "tencentcloud_sqlserver_db" "this" {
  for_each = var.dbs

  instance_id = var.instance_id
  name        = each.key
  charset     = each.value.charset
  remark      = each.value.remark
}
