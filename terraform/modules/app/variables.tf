variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}
variable subnet_id {
  description = "Subnets for modules"
}
variable "private_key_path" {
  description = "Path to the private key used for ssh access"
}
variable "mongod_ip" {
  description = "IP of mongo db"
}
