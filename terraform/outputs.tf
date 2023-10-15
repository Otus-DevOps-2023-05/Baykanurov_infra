output "external_ip_address_app" {
  value = [
    for instance in yandex_compute_instance.app :
    instance.network_interface.0.nat_ip_address
  ]
}

output "balancer_ip_address" {
  value = yandex_lb_network_load_balancer.reddit-app.listener[*].external_address_spec[*].address
}
