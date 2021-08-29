echo "-----------------------------"
echo"SCRIPT HECHO POR R4MON"
echo "-----------------------------"
echo "Descargando....."
wget https://download.mikrotik.com/routeros/6.48.4/chr-6.48.4.img.zip -O chr.img.zip
gunzip -c chr.img.zip > chr.img
sudo apt-get install kpartx
sudo kpartx -av chr.img
sudo mount -o loop /dev/mapper/loop3p1 /mnt  
ADDRESS=`ip addr show eth0 | grep global | cut -d' ' -f 6 | head -n 1`
GATEWAY=`ip route list | grep default | cut -d' ' -f 3`
echo "/ip address add address=$ADDRESS interface=[/interface ethernet find where name=ether1]
/ip route add gateway=$GATEWAY
" > /mnt/rw/autorun.scr
umount /mnt
echo u > /proc/sysrq-trigger
dd if=chr.img bs=1024 of=/dev/vda
echo "reiniciando...."
echo b > /proc/sysrq-trigger
