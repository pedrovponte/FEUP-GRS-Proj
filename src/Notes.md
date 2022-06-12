**Virtual machine names and IPs**

vmB
vm-BC-807 -> 192.168.88.101

vmC
vm-BC-808 -> 192.168.88.102


**Connect to vmA**

ssh -i g.rsa theuser@192.168.109.154

**Connect to vmB from vmA**

ssh -i privBC.rsa theuser@192.168.88.101

#Connect to vmC from vmA

ssh -i privBC.rsa theuser@192.168.88.102

#VM Management in Proxmox PVE

https://192.168.109.121:8006

#Github repository

https://github.com/Xavier-Pisco/GRS


#Scripts

To connect to a VM, run the following python script:
```shell
python ssh.py X
```

Example:
```shell
python ssh.py A
python ssh.py B
python ssh.py C
```

#How to install Docker on vm's B and C

##1) Enable access to internet for vm's B and C using vm A as the default gateway

We use 192.168.88.0/24 as the management network.
The IP of the configuration VM on the management network is 192.168.88.100 (on eth1).
We assume the configuration VM has another interface (eth0) which is the default gateway for the VM.
If the target VM is on 192.168.88.101, then we configure the default gateway on the target VM as 192.168.88.100 
and setup IP forwarding and NAT on the Configuration VM as follows :

**Config VM (vm A):**

sysctl -w net.ipv4.ip_forward=1
iptables -t nat -A POSTROUTING -s 192.168.88.101 -o eth0 -j MASQUERADE

**Target VM (vm B or C):**

ip r a default via 192.168.88.100

##2) Install docker

Run the following commands:

```shell
sudo apt-get update

sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io

sudo docker run hello-world```

##3) Allow non-sudo usage

Manage Docker as a non-root user (need to enter new terminal to have non-root 'docker ps' access)
```shell
sudo usermod -aG docker $USER
```

Configure Docker to start on boot
```shell
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
```

##4) Registry access

**Enable http registry (insecure)**

Edit /etc/docker/daemon.json, add registry ip and port:

```shell
{ "insecure-registries" : ["10.1.1.1:5000"] }
```

**Enable https registry (secure)**
Copy registry certificate to /etc/docker/certs.d/ using the ip and port number in the folder 
and filename (use : to escape the semicolon for the port)

```shell
/etc/docker/certs.d/1.1.1.1:5000/registry.crt
```

##5) Init docker swarm (optional?)

Run the following command:

```shell
docker swarm init
```