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

module "backup_strategy" {
  source = "../../modules/backup_strategy"

  instance_id = "mssql-xxxxx"

  # 每日备份
  backup_type      = "daily"
  backup_time      = 0
  backup_day       = 1
  backup_cycle     = [1]
  backup_model     = "slave_no_pkg"
  backup_save_days = 7

  # 归档备份（可选）
  regular_backup_enable     = "disable"
  regular_backup_save_days  = 365
  regular_backup_strategy   = "months"
  regular_backup_counts      = 1
}

output "backup_strategy_id" {
  value = module.backup_strategy.backup_strategy_id
}
