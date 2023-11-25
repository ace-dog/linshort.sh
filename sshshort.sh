function sshadd() { 
    read -p "hostname : " hostname
    read -p "port: press enter to set default 22 : " port
    read -p "username : " username
    read -p "password : " password
    sshcommand="hostname^$hostname&port^$port&username^$username&password^$password&"
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
    password=$(echo "$line" | awk -F'hostname\\^|&port\\^' '{print $2}')
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
sshpass -p $password ssh -o "StrictHostKeyChecking no" $username@$hostname -p $port
}


