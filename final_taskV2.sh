#!/bin/bash

# Function to add a user
add_user() {
    echo "Enter username:"
    read username
    echo "enter default password:"
    read password
    sudo adduser -m $username
    echo "$username:$password" | sudo chpasswd
}

# Function to add a group
add_group() {
    echo "Enter group name:"
    read groupname
    sudo groupadd $groupname
}

# Function to delete a group
delete_group() {
    echo "Enter group name:"
    read groupname
    sudo groupdel $groupname
}

# Function to edit a group
edit_group() {
    echo "Enter old group name:"
    read old_groupname
    echo "Enter new group name:"
    read new_groupname
    sudo groupmod -n $new_groupname $old_groupname
}

# Function to delete a user
delete_user() {
    echo "Enter username:"
    read username
    sudo userdel -f $username
}

# Function to edit a user
edit_user() {
  echo "Enter username:"
  read username

  echo "Choose an option:"
  echo "1. Change username"
  echo "2. Change UID"
  echo "3. Change password"
  echo "4. Add user to a group"
  read option

  case $option in
    1)
      echo "Enter new username:"
      read new_username
      sudo usermod -l $new_username $username
      ;;
    2)
      echo "Enter new UID:"
      read new_uid
      sudo usermod -u $new_uid $username
      ;;
    3)
      echo "Enter new password:"
      read -s new_password
      echo $new_password | sudo passwd --stdin $username
      ;;
    4)
      echo "Enter group to add the user to:"
      read group
      sudo usermod -aG $group $username
      ;;
    *)
      echo "Invalid option"
      ;;
  esac
}

# Main script
echo "Choose an option:"
echo "1. Add user"
echo "2. Delete user"
echo "3. Edit user"
echo "4. Add group"
echo "5. Delete group"
echo "6. Edit group"
read option

case $option in
    1)
        add_user
        ;;
    2)
        delete_user
        ;;
    3)
        edit_user
        ;;
    4)
        add_group
        ;;
    5)
        delete_group
        ;;
    6)
        edit_group
        ;;	
    *)
        echo "Invalid option"
        ;;
esac
