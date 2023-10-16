#!/bin/bash

echo "-------------------installation of nexus ------------------"

read -p "Enter file name of nexus: " file_name

# Generate a list of possible file names based on user input
file_list=$(compgen -f -- "$HOME/$file_name")

if [[ $file_list ]]; then
    # Prompt the user to select a file from the list of possible matches
    select file in $file_list; do
        # Extract the selected file with the tar command
        sudo tar -xvf "$file"
        break
    done
else
    echo "File does not exist"
fi


nexus_dirs=$(find "$HOME" -maxdepth 1 -type d -name "nexus*")

if [[ -n "$nexus_dirs" ]]; then
    echo "-----------There are 'Nexus' directories in your home directory------------"
    echo "$nexus_dirs"
else
    echo "-----------There are no 'Nexus' directories in your home directory--------------"
fi


if [[ -d "$HOME/sonatype-work" ]]; then
    echo "-----------The 'sonatype-work' directory exists in your home directory--------------"
else
    echo "-----------The 'sonatype-work' directory does not exist in your home directory-------------"
fi



#   rename the file nexus

for file in nexus-*; do


  filename=$(basename "$file")
  extension="${filename##*.}"

  # Construct the new filename
  new_filename="nexus"

  # Rename the file
  sudo mv "$file" "$new_filename"
done

echo "--------you did rename your file successfully -------------"

echo "------------create user nexus----------------------------"

if id "nexus" >/dev/null 2>&1; then
  echo "User 'nexus' already exists"
else
  sudo useradd nexus 

  sudo passwd nexus

fi

sudo mv nexus /opt
sudo mv sonatype-work /opt

sudo chown -R nexus:nexus /opt/nexus
sudo chown -R nexus:nexus /opt/sonatype-work

sudo sed -i 's|#run_as_user=""|run_as_user="nexus"|g' /opt/nexus/bin/nexus.rc

echo "------------changre to user nexus------------------"

# Running Nexus as a System Service

echo "-------------------Running Nexus as a System Service--------------------"

sudo sh -c "cat > /etc/systemd/system/nexus.service << EOF
[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
User=nexus
Group=nexus
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOF"

echo "-----------------------------add nexus service to boot------------------"

sudo systemctl enable nexus 

echo "-----------------------------start nexus------------------------------"

function print_rocket_launch {
    for i in {5..1}; do
        printf "\033c"
        echo "   _   "
        echo "  / \\  "
        echo " /   \\ "
        echo "/_____\\"
        echo "|     |"
        echo "|  $i  |"
        echo "|_____|\n"
        sleep 1
    done
    printf "\033c"
    echo "   _   "
    echo "  / \\  "
    echo " /   \\ "
    echo "/_____\\"
    echo "|     |"
    echo "|  🚀  |"
    echo "|_____|\n"
    sleep 1
}

for i in {10..0}; do
    espeak -v en "T minus $i"
    sleep 1
done

sudo systemctl start nexus
