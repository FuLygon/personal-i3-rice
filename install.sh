#!/bin/bash
clear
timestamp()
{
    date +"%Y-%m-%d %T"
}

# Set your custom config location here. 
# NOTE: i3, zsh config might need to be edited if default config file location is changed so be aware of that, you can fix it by look into their config file.
lightdmwebkit2=/usr/share/lightdm-webkit/themes
i3=$HOME/.i3
zsh=$HOME
p10k=$HOME
alacritty=$HOME/.config/alacritty
dunst=$HOME/.config/dunst
omz=$HOME/.config/ohmyzsh
polybar=$HOME/.config/polybar
rofi=$HOME/.config/rofi
picom=$HOME/.config

# Start the installation script
printf "\n\033[0;34mFuLygon's personal i3 dotsfiles installation script\n\n\033[0;37m"
printf "Default config file location. Edit this script if your location is different.

    - lightdm-webkit2:  $lightdmwebkit2
    - i3:               $i3/config
    - zsh:              $zsh/.zshrc
    - powerlevel10k:    $p10k/.p10k.zsh
    - alacritty:        $alacritty/alacritty.yml
    - dunst:            $dunst/dunstrc
    - ohmyzsh:          $omz
    - polybar:          $polybar
    - rofi:             $rofi
    - picom:            $picom/picom.conf
    \n"
PS3=$'\n'"Select your option: "
select _ in \
    "Install dotsfiles to local directory" \
    "Update dotsfiles from local directory" \
    "Exit"
do case $REPLY in
  1) 
    printf "\033[0;33mYou're going to install this dotfiles. This progress might need root password. Confirm your choice [y/n]: \033[0;37m"; read e
    case $e in
        Y|y) 
            echo "$(timestamp): Copying lightdm-webkit2-theme-glorious themes to $lightdmwebkit2"
            sudo mkdir -p $lightdmwebkit2 && sudo cp -r ./lightdm-webkit/glorious $_ && sudo sed -i 's/^\(#?greeter\)-session\s*=\s*\(.*\)/greeter-session = lightdm-webkit2-greeter #\1/ #\2g' /etc/lightdm/lightdm.conf
            echo "$(timestamp): Copying i3-gaps config to $i3"
            mkdir -p $i3 && cp ./.i3/config $_
            echo "$(timestamp): Copying zsh config to $zsh"
            cp .zshrc $zsh
            echo "$(timestamp): Copying powerlevel10k config to $p10k"
            cp .p10k.zsh $p10k
            echo "$(timestamp): Copying alacritty config to $alacritty"
            mkdir -p $alacritty && cp ./.config/alacritty/alacritty.yml $_
            echo "$(timestamp): Copying dunst config to $dunst"
            mkdir -p $dunst && cp ./.config/dunst/dunstrc $_
            echo "$(timestamp): Copying ohmyzsh files to $omz"
            mkdir -p $omz && cp -rf ./.config/ohmyzsh/. $_
            echo "$(timestamp): Copying polybar config to $polybar"
            mkdir -p $polybar && cp -rf ./.config/polybar/. $_
            echo "$(timestamp): Copying rofi config to $rofi"
            mkdir -p $rofi && cp -rf ./.config/rofi/. $_
            echo "$(timestamp): Copying picom config to $picom"
            mkdir -p $picom && cp ./.config/picom.conf $_
            printf "\033[0;36m$(timestamp): Done. You might need to logout for the changes to take effect\n"
            exit
            ;;
        N|n) echo "$(timestamp): Aborted";;
        *) printf "\033[0;31m$(timestamp): Invalid option. Aborted\033[0;37m\n";;
    esac
    ;;
  2)
    printf "\033[0;33mYou're going to update this dotfiles. This progress might need root password. Confirm your choice [y/n]: \033[0;37m"; read e
    case $e in
        Y|y)
            echo "$(timestamp): Retrieving lightdm-webkit2-theme-glorious themes from $lightdmwebkit2"
            mkdir -p ./lightdm-webkit/ && sudo cp -rf $lightdmwebkit2/glorious $_ && sudo chown -R $USER ./lightdm-webkit/glorious
            echo "$(timestamp): Retrieving i3-gaps config from $i3"
            mkdir -p ./.i3 && cp $i3/config $_
            echo "$(timestamp): Retrieving zsh config from $zsh"
            cp $zsh/.zshrc .
            echo "$(timestamp): Retrieving powerlevel10k config from $p10k"
            cp $p10k/.p10k.zsh .
            echo "$(timestamp): Retrieving alacritty config from $alacritty"
            mkdir -p ./.config/alacritty && cp $alacritty/alacritty.yml $_
            echo "$(timestamp): Retrieving dunst config from $dunst"
            mkdir -p ./.config/dunst && cp $dunst/dunstrc $_
            echo "$(timestamp): Retrieving ohmyzsh files from $omz"
            mkdir -p ./.config/ohmyzsh && cp -rf $omz/. $_
            echo "$(timestamp): Retrieving polybar config from $polybar"
            mkdir -p ./.config/polybar && cp -rf $polybar/. $_
            echo "$(timestamp): Retrieving rofi config from $rofi"
            mkdir -p ./.config/rofi && cp -rf $rofi/. $_
            echo "$(timestamp): Retrieving picom config from $picom"
            mkdir -p ./.config/ && cp $picom/picom.conf $_
            printf "\033[0;36m$(timestamp): Done\n"
            exit
            ;;
        N|n) echo "$(timestamp): Aborted";;
        *) printf "\033[0;31m$(timestamp): Invalid option. Aborted\033[0;37m\n";;
    esac
    ;;
  3) 
    exit
    ;;
  *) 
    printf "\033[0;31m\nInvalid option. Do you want to exit [y/n]: \033[0;37m"; read e
    case $e in
        Y|y) exit;;
        N|n) ;;
    esac
    ;;
esac
done
