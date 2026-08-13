# 1. SQL Server basic instance
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
  time_zone = each.value.time_zone

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

# 2. SSL 加密（ssl_type 不为 null 时创建）
resource "tencentcloud_sqlserver_instance_ssl" "this" {
  for_each = {
    for k, v in var.sqlserver_instances : k => v
    if v.ssl_type != null
  }

  instance_id = tencentcloud_sqlserver_basic_instance.this[each.key].id
  type        = each.value.ssl_type

  depends_on = [tencentcloud_sqlserver_basic_instance.this]
}

# 3. 实例级 TDE 透明数据加密（tde_certificate_attribution 不为 null 时创建）
resource "tencentcloud_sqlserver_instance_tde" "this" {
  for_each = {
    for k, v in var.sqlserver_instances : k => v
    if v.tde_certificate_attribution != null
  }

  instance_id             = tencentcloud_sqlserver_basic_instance.this[each.key].id
  certificate_attribution = each.value.tde_certificate_attribution
  quote_uin               = each.value.tde_quote_uin

  depends_on = [tencentcloud_sqlserver_basic_instance.this]
}

# 4. 数据库级 TDE 加密（tde_db_names 不为 null 时创建）
resource "tencentcloud_sqlserver_database_tde" "this" {
  for_each = {
    for k, v in var.sqlserver_instances : k => v
    if v.tde_db_names != null
  }

  instance_id = tencentcloud_sqlserver_basic_instance.this[each.key].id
  db_names     = each.value.tde_db_names
  encryption   = "enable"

  depends_on = [tencentcloud_sqlserver_instance_tde.this]
}
