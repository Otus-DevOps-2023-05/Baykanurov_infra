# Baykanurov_infra
Baykanurov Infra repository

## Cloud Bastion
### VM address
bastion_IP = 158.160.107.73
someinternalhost_IP = 10.128.0.16

### Подключение к someinternalhost
1. Создадим файл `~/.ssh/config`
```bash
touch ~/.ssh/config && chmod 600 ~/.ssh/config
```
2. Запишем в него конфигурацию подключения к bastion и someinternalhost
```bash
Host bastion
HostName 158.160.107.73
User baykanurov

Host someinternalhost
HostName 10.128.0.16
ProxyJump bastion
User baykanurov
```
3. Проверим подключение
```bash
ssh someinternalhost
```
P.S. Конфигурация в файле `~/.ssh/config` также позволяет нам подключаться к bastion
```bash
ssh bastion
```

### Создание VPN-сервера
Скрипт `setupvpn.sh` устанавливает VPN-cервер `pritunl`
```bash
sudo bash setupvpn.sh
```
После установки открываем в браузере https://158.160.107.73/setup и следуем инструкциям
Чтобы получить логин и пароль для входа нужно ввести команду:
```bash
sudo pritunl default-password
```

### Подключение к someinternalhost через VPN
После добавления конфигурационного файла cloud-bastion.ovpn в клиент
OpenVPN, можно проверить успешность подключения командой:
```bash
ssh -i ~/.ssh/id_rsa baykanurov@10.128.0.16
```

## Cloud Testapp
### Testapp Info
testapp_IP = 51.250.74.93
testapp_port = 9292

### Дополнительное задание
Startup Script находится в файле startup.sh
#### Используемая команда CLI:
```shell
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --metadata-from-file user-data=./startup.sh \
  --ssh-key ~/.ssh/id_ed25519.pub
```
Данная команда триггерит после создания нового инстанса ВМ скрипт startup.sh который проводит полную установку и развертование приложения, в том числе с установкой и разверткой дополнительных компонентов.


## Packer Base
### Что было сделано
1. Установлен Packer версии 1.8.7.
2. Создан сервисный аккаунт для Packer в Yandex.Cloud.
3. Создан файл ubuntu16.json для создания reddit-base образа.
4. Создана вм `packer-base-dz` на основе reddit-base образа на ней развернуто приложение reddit.
Доступность можно проверить по адресу `http://51.250.90.203:9292/`
5. Также был параметризован ubuntu16.json.
Команда запуска `packer build -var-file ./variables.json ./ubuntu16.json`

### Дополнительное задание
1. Были созданы следующие файлы:
- **immutable.json** - для создания reddit-full образа.
- **files/deploy.sh** - установка reddit и запуск сервиса.
- **files/puma.service** - копируется в образ для настройки работы reddit как сервиса.

Команда запуска:
`packer build -var-file ./variables.json ./immutable.json`

2. Был создан скрипт **config-scripts/create-reddit-vm.sh** который создаёт ВМ из образа reddit-full.

## Terraform-1
Версия Terraform: 0.12.8
Версия provider.yandex: 0.56.0
### Файлы:
- main.tf - содержит интсрукции по созданию инстанса ВМ с Reddit из базового образа (reddit-base)
- variables.tf - описание переменных
- terraform.tvars - значения переменных (пример в terraform.tvars.example)
- outputs.tf - выходные переменные
### Дополнительное задание
1. Файл lb.tf содержит инструкции по созданию балансировщика нагрузки и группы для него;
2. Для использования только одного файла для создания нескольких инстансов reddit-app была использована опция Count

## Terraform-2
- Конфигурация инфраструктуры разделена на 2 модуля app и db
- Настроено переиспользование модулей (stage и prod)
### Дополнительное задание
- Настроил Хранилище S3 для сохранения terraform.tfstate
- Настроил provisioner для модулей app и db
