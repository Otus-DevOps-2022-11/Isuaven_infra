# Isuaven_infra
Isuaven Infra repository

## cloud-bastion
Простейший способ подключения к someinternalhost:
```bash
ssh -i ~/.ssh/appuser -A -t appuser@${bastion_ip} 'ssh ${someinternalhost_ip}'
```
где заменяем `${bastion_ip}` на IP хоста bastion и `${someinternalhost_ip}` на IP хоста __someinternalhost__ из интерфейса YC \
или можно даже задать их как переменные типа
```bash
export bastion_ip=$(yc compute instance list | grep bastion | awk -F"|" '{print $6}' | tr -d ' ')
export someinternalhost_ip=$(yc compute instance list | grep someinternalhost | awk -F"|" '{print $7}' | tr -d ' ')
```
Для подключения по алиасу необходимо прописать параметры хостов `~/.ssh/config`:
```
Host bastion
        Hostname bastion_ip
        User appuser
        IdentityFile ~/.ssh/appuser
        ForwardAgent yes

Host someinternalhost
        Hostname someinternalhost_ip
        User appuser
        IdentityFile ~/.ssh/appuser
        ProxyJump bastion
```
где предварительно необходимо сконфигугрировать Hostname адреса обоих хостов.
```
bastion_IP = 84.201.131.80
someinternalhost_IP = 10.128.0.18
```
## cloud-testapp
```
testapp_IP = 84.201.157.27
testapp_port = 9292
```
Для деплоя инстанса с уже установленным приложением требуется создавать его с помощью команды их папки где располагается файл `metadata.yaml`
```bash
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --metadata-from-file user-data=./metadata.yaml \
  --ssh-key ~/.ssh/appuser.pub
```

## packer-base
- Создан стандартный образ ubuntu16.json через packer
- Шаблон параметризирован
- Переменные внесены в variables.json
- Создан bake-образ immutable.json
- Создан скрипт create-reddit-vm.sh который будет создавать ВМ с помощью Yandex.Cloud CLI

## terraform-1
- Установлен и настроен terraform и провайдер yandex (ВНИМАНИЕ: Не удалось по рекомендациям к ДЗ установить версии 0.12.х и 0.35, были использованы 1.3.0 и 0.44.1
- Описан инстанс reddit-app
- Настроен вывод output var
- Добавлены provisioner для автоматической пост настройки сервиса на инстансе
- Добавлены Input vars для параметризации конфига
- Выполнены все самостоятельные задания, в т.ч. с созданием HTTP балансировщика
- Проблема в первой резализации reddit-app2, что он создаётся отдельным инстансом с отдельным конфигом, хотя должен быть просто копией первого приложения
- Добавлена переменная count изменяющая кол-во инстансов и внесены необходимые изменения в файлы, где что-то ссылается на переменные с app

## terraform-2
- Добавлена модульная схема развёртки инстансов
- Сделаны ветки stage и prod
- Настроено хранение state на удалённом backend
- Вовзращены provisioner для полноценной развёрки приложения
