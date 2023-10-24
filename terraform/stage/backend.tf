#terraform {
#  backend "s3" {
#    endpoint                    = "storage.yandexcloud.net"
#    bucket                      = "s3-otus-devops"
#    region                      = "ru-central1-a"
#    key                         = "terraform/stage/terraform.tfstate"
#    skip_region_validation      = true
#    skip_credentials_validation = true
#  }
#}
