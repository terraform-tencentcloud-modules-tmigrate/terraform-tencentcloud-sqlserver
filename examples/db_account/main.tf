terraform {
  required_version = ">= 1.5.0"

  required_providers {
    tencentcloud = {
      source  = "tencentcloudstack/tencentcloud"
      version = ">= 1.81.155"
    }
  }
}

provider "tencentcloud" {
  region = "ap-shanghai"
}

module "db_accounts" {
  source = "../../modules/db_account"

  instance_id = "mssql-xxxxx"

  # 高级权限账号：自动拥有所有 DB 的 db_owner，不需要 db_attachments
  admin_accounts = {
    "admin_tf" = {
      password = "YourPassword123!"
      remark   = "tf managed admin"
    }
  }

  # 普通账号：绑定 db example 里的 app_db 和 log_db
  normal_accounts = {
    "app_rw" = {
      password = "YourPassword123!"
      remark   = "read-write on both dbs"
      db_attachments = [
        { db_name = "app_db", privilege = "ReadWrite" },
        { db_name = "log_db", privilege = "ReadWrite" },
      ]
    }
    "app_ro" = {
      password = "YourPassword123!"
      remark   = "read-only on app_db"
      db_attachments = [
        { db_name = "app_db", privilege = "ReadOnly" },
      ]
    }
  }

  # NOTE: 特殊权限账号不被 Terraform provider 支持，请使用控制台/工单创建。
}

output "admin_account_ids" {
  value = module.db_accounts.admin_account_ids
}

output "normal_account_ids" {
  value = module.db_accounts.normal_account_ids
}

output "normal_db_attachment_ids" {
  value = module.db_accounts.normal_db_attachment_ids
}
