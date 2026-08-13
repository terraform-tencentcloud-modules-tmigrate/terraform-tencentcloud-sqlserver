resource "tencentcloud_sqlserver_basic_instance" "this" {
  for_each = var.sqlserver_instances

  name              = each.value.name
  availability_zone = each.value.availability_zone
  memory            = each.value.memory
  storage           = each.value.storage
  cpu               = each.value.cpu
  machine_type      = each.value.machine_type
  engine_version    = each.value.engine_version
  charge_type       = each.value.charge_type

  vpc_id    = each.value.vpc_id
  subnet_id = each.value.subnet_id

  collation = each.value.collation

  maintenance_week_set   = each.value.maintenance_week_set
  maintenance_start_time = each.value.maintenance_start_time
  maintenance_time_span  = each.value.maintenance_time_span

  disk_encrypt_flag = each.value.disk_encrypt_flag

  security_groups = each.value.security_groups

  project_id   = each.value.project_id
  auto_renew   = each.value.auto_renew
  auto_voucher = each.value.auto_voucher
  voucher_ids   = each.value.voucher_ids
  period        = each.value.period

  tags = each.value.tags
}
