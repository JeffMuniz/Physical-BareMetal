
apt update && apt upgrade -y
vim /etc/ssh/sshd_config
systemctl enable postgresql
systemctl start  postgresql
systemctl start sshd 
systemctl enable sshd 
systemctl restart systemd-resolved
service sshd start
service sshd restart


netstat -utplan|grep post
netstat -utplan|grep 22
wget https://anydesk.com/pt/downloads/thank-you?dv=deb_64
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install ./google-chrome-stable_current_amd64.deb
apt install xbase-clients python3-psutil libgtkglext1 -y
dpkg -i anydesk_6.2.0-1_amd64.deb
dpkg -i chrome-remote-desktop_current_amd64.deb 

updatedb
apt autoremove
init 6





apt update && apt upgrade -y
vim /etc/ssh/sshd_config
systemctl enable postgresql
systemctl start  postgresql
systemctl start sshd 
systemctl enable sshd 
systemctl restart systemd-resolved
service sshd start
service sshd restart


netstat -utplan|grep post
netstat -utplan|grep 22
wget https://anydesk.com/pt/downloads/thank-you?dv=deb_64
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install ./google-chrome-stable_current_amd64.deb
apt install xbase-clients python3-psutil libgtkglext1 -y
dpkg -i anydesk_6.2.0-1_amd64.deb
dpkg -i chrome-remote-desktop_current_amd64.deb 

updatedb
apt autoremove
init 6
