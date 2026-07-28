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

module "dbs" {
  source = "../../modules/db"

  instance_id = "mssql-xxxxx"

  dbs = {
    "app_db" = {
      charset = "Chinese_PRC_CI_AS"
      remark  = "application database"
    }
    "log_db" = {
      charset = "Chinese_PRC_CI_AS"
      remark  = "log database"
    }
  }
}

output "db_ids" {
  value = module.dbs.db_ids
}

output "db_statuses" {
  value = module.dbs.db_statuses
}
