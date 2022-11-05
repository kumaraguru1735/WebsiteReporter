clear
#dir setup
echo "hello " $whomai 
read -p "Enter project name: " project_name
read -p "Enter the domain name [without http or https]: " domain_name
mkdir /home/$whomai/$project_name
cd /home/$whoami/$project_name
clear
#Downloading important tools
mkdir tools
cd tools
git clone https://github.com/HarshitJosh1/subscannon.git
chmod +x subscannon/setup.sh
printf"Please Enter sudo password"
sudo bash subscannon/setup.sh

#scanning header with whatweb
clear
printf"-----------5% completed-----------"
whatweb -v $domain_name > whatweb_$domain_name.txt

#scanning for subdomain
clear
printf"-----------20% completed-----------"
printf"Searching for subdomain"
echo ""
python3 subscannon/ubscannon.py -d $domain_name > subdomain_$domain_name.txt

#scanning for subdirectories
clear
printf"-----------50% completed-----------"
printf"Doing Dirhunt..."
dirhunt $domain_name > dirhunt_$domain_name.txt

#Scanning with nmap
clear
printf"-----------70% completed-----------"
printf"Scanning via nmap"
mkdir nmap
echo ""
nmap -A -sV -T4 -p- $domain_name --stats-every=3s --oA nmap/$domain_name


printf $domain_name " website reports are generated in the text files...."