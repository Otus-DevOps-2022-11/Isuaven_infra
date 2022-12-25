# Isuaven_infra
Isuaven Infra repository

Простейший способ подключения к someinternalhost:
 ssh -i ~/.ssh/appuser -A -t appuser@${bastion_ip} 'ssh ${someinternalhost_ip}'
где заменяем ${bastion_ip} на IP хоста bastion и ${someinternalhost_ip} на IP хоста someinternalhost из интерфейса YC
или можно даже задать их как переменные типа
export bastion_ip=$(yc compute instance list | grep bastion | awk -F"|" '{print $6}' | tr -d ' ')
export someinternalhost_ip=$(yc compute instance list | grep someinternalhost | awk -F"|" '{print $7}' | tr -d ' ')

Для подключения по алиасу необходимо прописать параметры хостов ~/.ssh/config:
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

где предварительно необходимо сконфигугрировать Hostname адреса обоих хостов.

bastion_IP = 84.201.131.80
someinternalhost_IP = 10.128.0.18
