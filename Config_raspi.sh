#!/bin/sh
Menu () {
    echo "Prérequis : lancer la commande : tail -f /var/log/messages afin de voir quel est le nom du périphérique USB branché (exemple : sda1)"
    echo ""
    echo "1 - Mise a jour et installation des paquets de base"
    echo "2 - Config de la raspi"
    echo "3 - Vérifier le fonctionnement des services"
    echo "4 - Arret du script"
    echo ""
    read -r "Choisissez une option (1-3) : " Input_String
    case $Input_String in 
        1)
            UpdateAndInstallAndEnable    
        ;;
        2)
            ConfigRaspi
        ;;
        3)
            echo "!! Arrêt du script !!"
            return
        ;;
        *)
            echo "Entrée invalide, veuillez tapper un chiffre entre 1 et 4"
        ;;
        esac
}

UpdateAndInstallAndEnable () {
#Update
sudo apt update && sudo apt upgrade -y

#Install
sudo apt-get install ntfs-3g -y
sudo apt install samba -y

#Enable
sudo service smbd enable

clear

#Retour au menu
Menu
} 

ConfigRaspi () {
#Montage du disque en ntfs
read -p "Entrer le nom du périphérique (ex : sda1)" disk
sudo mkdir /mnt/HDD
sudo mount /dev/$(disk) /mnt/HDD
sudo chown -R fguillouet:fguillouet /mnt/HDD
sudo chmod -R 755 /mnt/HDD

pause

clear 

#Retour au menu
Menu
}
Menu