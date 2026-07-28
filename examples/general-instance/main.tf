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

# ─── 入参，等待填写 ───

locals {
  name         = "test-sqlserver-tf"
  zone         = "ap-shanghai-5"
  memory       = 4    # GB
  storage      = 20   # GB
  cpu          = 2
  machine_type = "CLOUD_HSSD"
  db_version   = "2022"

  vpc_id     = "vpc-xxxxx"
  subnet_id  = "subnet-xxxxx"

  # 维护窗口
  weekly     = [1, 2, 3, 4, 5, 6, 7]
  start_time = "00:00"
  span       = 6

  # 其他
  auto_renew_flag   = 0
  disk_encrypt_flag = 1
  multi_zones       = true

  # 安全组（由 config_instance_security_groups 接管，不再用 security_group_list）
  security_group_id_set = ["sg-xxxxx"]

  # 实例参数
  instance_params = [
    { name = "fill factor(%)", current_value = "80" },
    { name = "max degree of parallelism", current_value = "0" },
  ]

  # 外网访问：null=不管 true=开启 false=关闭(需已开启)
  enable_wan_ip = null

  # SSL：null=不管 enable=开启 disable=关闭(需已开启) renew=续期
  ssl_type = null

  # TDE 透明数据加密：null=不管 self=自有证书 others=引用其他账号证书
  tde_certificate_attribution = null
}

module "instance" {
  source = "../../modules/general-instance"

  name                = local.name
  zone                = local.zone
  memory              = local.memory
  storage             = local.storage
  cpu                 = local.cpu
  machine_type        = local.machine_type
  db_version          = local.db_version
  instance_charge_type = "POSTPAID"

  vpc_id              = local.vpc_id
  subnet_id           = local.subnet_id

  collation = "Chinese_PRC_CI_AS"
  time_zone = "China Standard Time"

  weekly           = local.weekly
  start_time        = local.start_time
  span              = local.span
  auto_renew_flag   = local.auto_renew_flag
  disk_encrypt_flag = local.disk_encrypt_flag
  multi_zones       = local.multi_zones

  # 集成的功能
  security_group_id_set      = local.security_group_id_set
  instance_params            = local.instance_params
  enable_wan_ip              = local.enable_wan_ip
  ssl_type                   = local.ssl_type
  tde_certificate_attribution = local.tde_certificate_attribution
}

output "instance_id" {
  value = module.instance.instance_id
}

output "wan_dns_pod_domain" {
  value = module.instance.wan_dns_pod_domain
}

output "wan_tgw_wan_vport" {
  value = module.instance.wan_tgw_wan_vport
}
