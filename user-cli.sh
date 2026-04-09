#!/bin/bash  

## PERSONAL PROJECT, 2026
## linux-user-cli
## File description:
## second Linux/Bash project in my DevOps learning journey                       
## a command-line interface (CLI) tool that allows you to manage Linux users
##

echo -e "Welcome to the linux-user-cli project !\n"
echo -e "Choose one option in the menu below.\n"

echo "MENU"
echo "1 - Create user"
echo "2 - Delete user"
echo "3 - Check user"
echo -e "4 - Exit\n"

read option
case "$option" in
    "1")
        echo "Enter the name of the user you want to create :"
        read username
        echo "Enter its password :"
        read -s passw1
        echo "Confirm the password :"
        read -s passw2
        if [[ "$passw1" == "$passw2" ]]; then
            echo "Good password"
            # useradd ${username}
            # passwd ${username}
        else
            echo "Wrong password"
        fi
        ;;
    "2")
        echo "Enter the name of the user you want to delete :"
        read username
        echo "Do you want to delete the user's directory ? Type yes or no."
        read y_n
        if [[ "${y_n,,}" == "yes" ]]; then
            echo "Bye bye ${username} !"
            # userdel -r ${username}
        else
            echo "type yes or no."
            # userdel ${username}
        fi
        ;;
    "3")
        echo "Enter the name of the user you want to check :"
        read username
        if [ id ${username} ]; then
            echo "User ${username} exists."
        else
            echo "User ${username} doesn't exist."
        fi
        ;;
    "4")
        echo "Bye bye ! Mouah !"
        exit 0
        ;;
esac
