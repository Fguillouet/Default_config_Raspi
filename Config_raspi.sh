#/bin/sh
function Menu {
    echo "Prérequis : lancer la commande :tail -f /var/log/messages afin de voir quel est le nom du périphérique USB branché (exemple : sda1)"
    echo "Mise a jour et installation des paquets de base"
    echo "Config de la raspi"
    echo "Vérifier le fonctionnement des services"
}

function UpdateAndInstallAndEnable {
#Update
sudo apt update && sudo apt upgrade -y

#Install
sudo apt-get install ntfs-3g -y
sudo apt install samba -y

#Enable
sudo service smbd enable
} 

function ConfigRaspi{
#Montage du disque en ntfs
read -p "Entrer le nom du périphérique (ex : sda1)" disk
sudo mkdir /mnt/HDD
sudo mount -t ntfs-3g /dev/$disk /mnt/HDD
sudo chown -R pi:pi /mnt/HDD
sudo chmod -R 755 /mnt/HDD
}

function Check Services {
sudo service smbd status
sudo service ntfs-3g status
}
