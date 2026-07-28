locals {
  # Admin accounts (skip when not creating)
  admin_accounts = { for k, v in var.admin_accounts : k => v if var.create }

  # Normal accounts (skip when not creating)
  normal_accounts = { for k, v in var.normal_accounts : k => v if var.create }

  # Flatten normal attachments into map keyed by "accountName|dbName"
  normal_attachments = {
    for pair in flatten([
      for name, acct in local.normal_accounts : [
        for a in acct.db_attachments : {
          key        = "${name}|${a.db_name}"
          account    = name
          db_name    = a.db_name
          privilege  = a.privilege
        }
      ]
    ]) : pair.key => pair
  }
}

# ─── 高级权限账号 ───
resource "tencentcloud_sqlserver_account" "admin" {
  for_each = local.admin_accounts

  instance_id = var.instance_id
  name        = each.key
  password    = each.value.password
  is_admin    = true
  remark      = try(each.value.remark, "")

  # is_admin cannot be changed after creation (provider enforces).
  lifecycle {
    ignore_changes = [is_admin]
  }
}

# ─── 普通账号 ───
resource "tencentcloud_sqlserver_account" "normal" {
  for_each = local.normal_accounts

  instance_id = var.instance_id
  name        = each.key
  password    = each.value.password
  is_admin    = false
  remark      = try(each.value.remark, "")

  lifecycle {
    ignore_changes = [is_admin]
  }
}

# ─── 普通账号的 DB 绑定 ───
resource "tencentcloud_sqlserver_account_db_attachment" "normal" {
  for_each = local.normal_attachments

  instance_id  = var.instance_id
  account_name = each.value.account
  db_name      = each.value.db_name
  privilege    = each.value.privilege

  depends_on = [tencentcloud_sqlserver_account.normal]
}
