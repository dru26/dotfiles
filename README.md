# dotfiles
 
Install Arch following the [installation guide](https://wiki.archlinux.org/title/Installation_guide) and ensure the following packages are downloaded:

```
sudo
vi
```

Make sure to enable the network (`systemctl enable systemd-networkd.service`) and add the following line to `/etc/resolv.conf`

```
nameserver 8.8.8.8
```

Also, make a user using `useradd -m -G wheel username && passwd username` then uncomment the following line from `visudo` to enable sudo access for wheel

```%wheel      ALL=(ALL:ALL) ALL```
 
We first install git, download the install file, and install:

```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/dru26/dotfiles/main/install.sh)" && . install.sh && rm install.sh
```


