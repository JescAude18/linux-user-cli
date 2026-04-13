#!/bin/bash  

## PERSONAL PROJECT, 2026
## linux-user-cli
## File description:
## second Linux/Bash project in my DevOps learning journey                       
## a command-line interface (CLI) tool that allows you to manage Linux users
##

echo -e "Welcome to the linux-user-cli project !\n"

if [[ "$EUID" -ne 0 ]]; then
    echo -e "Launch the script with sudo or being root.\n"
    exit 1
fi

for cmd in id useradd userdel passwd; do
    if ! command -v "$cmd" >/dev/null; then
        echo -e "--> Error : command '${cmd}' not found.\n" >&2
        exit 1
    fi
done

while true; do
    echo -e "Choose one option in the menu below.\n"
    echo "-----------------------------| MENU |------------------------------"
    echo "|                         1 - Create user                         |" 
    echo "|                         2 - Delete user                         |"
    echo "|                         3 - Check user                          |"
    echo "|                         4 - Exit                                |"
    echo -e "-------------------------------------------------------------------\n"
    read -r option
    case "$option" in
        "1")
            echo "Enter the name of the user you want to create :"
            read -r username
            if id "${username}" >/dev/null 2>&1; then
                    echo -e "--> ERROR : User ${username} already exists. Retry.\n"
            else
                if useradd -m "${username}" >/dev/null 2>&1; then
                    echo "Enter password for user ${username} :"
                    if passwd "${username}"; then
                        echo -e "--> COMPLETED : User ${username} created successfully !\n"
                    else
                        echo -e "--> ERROR : Password creation failed. User ${username} created without password.\
                        Choose option 2 of the menu to delete the user.\n"
                    fi
                else
                    echo -e "--> ERROR : Failed to create user ${username}.\n"
                fi
            fi
            ;;
        "2")
            echo "Enter the name of the user you want to delete :"
            read -r username
            if [[ "${username}" == "root" ]]; then
                echo -e "--> ERROR : Impossible to delete root.\n"
                continue
            elif [[ -n "${SUDO_USER:-}" && "${username}" == "$SUDO_USER" ]]; then
                echo -e "--> ERROR : Impossible to delete current user.\n"
                continue
            fi
            echo "--> WARNING : Do you want to delete the user's directory ? Type yes or no."
            read -r y_n
            if [[ "${y_n,,}" == "yes" ]]; then
                if id "${username}" >/dev/null 2>&1; then
                    echo "--> WARNING : Are you sure to delete the user ${username} with its directory ? Type yes or no."
                    read -r sure
                    if [[ "${sure,,}" == "yes" ]]; then
                        if userdel -r "${username}" >/dev/null 2>&1; then
                            echo -e "--> COMPLETED : Bye bye ${username} !\n"
                        else
                            echo -e "Failed to delete user ${username} with its directory.\n"
                        fi
                    elif [[ "${sure,,}" == "no" ]]; then
                        echo -e "--> INFO : Ok, type another option in the menu.\n"
                    else
                        echo -e "--> INFO : Ok, type another option in the menu.\n"
                    fi
                else
                    echo -e "--> ERROR : User ${username} doesn't exist. Type a valid user to delete.\n"
                fi
            elif [[ "${y_n,,}" == "no" ]]; then
                if id "${username}" >/dev/null 2>&1; then
                    echo "--> WARNING : Are you sure to delete the user ${username} ? Type yes or no."
                    read -r sure
                    if [[ "${sure,,}" == "yes" ]]; then
                        if userdel "${username}" >/dev/null 2>&1; then
                            echo -e "--> COMPLETED : Bye bye ${username} !\n"
                        else
                            echo -e "Failed to delete user ${username}.\n"
                        fi
                    elif [[ "${sure,,}" == "no" ]]; then
                        echo -e "--> INFO : Ok, type another option in the menu.\n"
                    else
                        echo -e "--> INFO : Ok, type another option in the menu.\n"
                    fi
                else
                    echo -e "--> ERROR : User ${username} doesn't exist. Type a valid user to delete.\n"
                fi
            else
                echo -e "--> INFO : Type yes or no.\n"
            fi
            ;;
        "3")
            echo "Enter the name of the user you want to check :"
            read -r username
            if id "${username}" >/dev/null 2>&1; then
                echo -e "--> COMPLETED : User ${username} exists.\n"
            else
                echo -e "--> COMPLETED : User ${username} doesn't exist.\n"
            fi
            ;;
        "4")
            echo -e "--> Bye bye ! Thanks to coming to the linux-user-cli projet 🥂\n"
            break
            ;;
        *)
            echo -e "--> INFO : Type a valid value : 1, 2, 3 or 4\n"
            ;;
    esac
done
