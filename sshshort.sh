function sshadd() { 
    read -p "hostname : " hostname
    read -p "port: press enter to set default 22 : " port
    read -p "username : " username
    read -p "password : " password
    sshcommand="hostname^$hostname&port^$port&username^$username&password^$password&^"
    echo $sshcommand >> $linshortpath/sshsrclist
}
function sshrm() {
    sed -i "$1d" $linshortpath/sshsrclist
}

function sshcnt() {
    echo "$(wc -l $linshortpath/sshsrclist | cut -d' ' -f1)"
}
function sshlst() {
filename="$linshortpath/sshsrclist"
line_number=1
while IFS= read -r line; do
    hostname=$(echo "$line" | awk -F'hostname\\^|&port\\^' '{print $2}')
    port=$(echo "$line" | awk -F'port\\^|&username\\^' '{print $2}')
    username=$(echo "$line" | awk -F'username\\^|&password\\^' '{print $2}')
    password=$(echo "$line" | awk -F'password\\^|&\\^' '{print $2}')
    ssh_connect="$line_number $username@$hostname -p $port"
    echo $ssh_connect
    ((line_number++))
done < "$filename"
}
function sshcon() {
filename="$linshortpath/sshsrclist"
line_number=$1
while IFS= read -r line; do
    ((line_number--))
    if [ "$line_number" -eq 0 ]; then
        hostname=$(echo "$line" | awk -F'hostname\\^|&port\\^' '{print $2}')
        port=$(echo "$line" | awk -F'port\\^|&username\\^' '{print $2}')
        username=$(echo "$line" | awk -F'username\\^|&password\\^' '{print $2}')
        password=$(echo "$line" | awk -F'password\\^|&\\^' '{print $2}')
        break
    fi
done < "$filename"
echo "sshpass -p $password ssh $username@$hostname -p $port"
sshpass -p $password ssh $username@$hostname -p $port
}
function linssh() {
init_memu=$(whiptail --title "sshshort" --menu "Menu" 0 0 0 \
"1"  "Add connection" \
"2"  "Remove connection" \
"3"  "Connet to"  3>&1 1>&2 2>&3)
if [[ $init_memu != "" ]]; then
    case $init_memu in
        1)
            sshaddu
            linssh
            ;;
        2)
            source=$(sshsrcsel)
            sshrm $source
            linssh
            ;;
        3)
            source=$(sshsrcsel)
            sshcon $source
            ;;
    esac
fi
}
function sshaddu() {
    hostname=$(whiptail --title "Add Connection" --inputbox "hostname" 0 0  3>&1 1>&2 2>&3)
    port=$(whiptail --title "Add Connection" --inputbox "port: press enter to set default 22" 0 0  3>&1 1>&2 2>&3)
    username=$(whiptail --title "Add Connection" --inputbox "username" 0 0  3>&1 1>&2 2>&3)
    password=$(whiptail --title "Add Connection" --inputbox "password" 0 0  3>&1 1>&2 2>&3)
    sshcommand="hostname^$hostname&port^$port&username^$username&password^$password&^"
    echo $sshcommand >> $linshortpath/sshsrclist
}
function sshsrcsel() {
srclist=()
filename="$linshortpath/sshsrclist"
line_number=1
srcselect=ON
while IFS= read -r line; do
    hostname=$(echo "$line" | awk -F'hostname\\^|&port\\^' '{print $2}')
    port=$(echo "$line" | awk -F'port\\^|&username\\^' '{print $2}')
    username=$(echo "$line" | awk -F'username\\^|&password\\^' '{print $2}')
    password=$(echo "$line" | awk -F'hostname\\^|&port\\^' '{print $2}')
    srclist+=("$line_number" "$username@$hostname -p $port" "OFF")
    srcselect=OFF
    ((line_number++))
done < "$filename"
selected_option=$(whiptail --title "Radio list example" --radiolist \
"Choose user's permissions" 0 0 0 \
"${srclist[@]}" 3>&1 1>&2 2>&3)
echo $selected_option
}



