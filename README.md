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
