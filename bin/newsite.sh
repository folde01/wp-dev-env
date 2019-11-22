#!/usr/bin/env bash

site_name="$1"
wde_root="$HOME/wp-dev-env"
wde_ports_file="$wde_root/config/ports.txt"
docker_vol_dir="$wde_root/docker-volumes"
docker_compose_dir="$wde_root/docker-compose"
docker_compose_template="$wde_root/templates/docker-compose.yml"
docker_compose_file="$docker_compose_dir/$site_name/docker-compose.yml"


# folder structure with docker-compose.yml template

mkdir $docker_vol_dir/wordpress_db/$site_name
mkdir $docker_vol_dir/wordpress_files/$site_name

mkdir $docker_compose_dir/$site_name
cp $docker_compose_template $docker_compose_file


# docker-compose.yml volume paths end with $site_name

old_text="docker-volumes/wordpress_db"
new_text="$old_text/$site_name"
sed -i "s|$old_text|$new_text|" $docker_compose_file

old_text="docker-volumes/wordpress_files"
new_text="$old_text/$site_name"
sed -i "s|$old_text|$new_text|" $docker_compose_file


# web server is accessed via a unique network port on host

starting_port=8000

port_line=`grep $site_name $wde_ports_file`

if [ -z "$port_line" ]; then
    highest_port=`cat $wde_ports_file| awk '{ print $2}' | cut -d: -f1 | sort -nr | head -1`

    if [ -z  "highest_port" ]; then
        highest_port=$starting_port
    fi

    port_line="$site_name $((highest_port + 1)):80"
    echo "$port_line" >> $wde_ports_file
fi

old_text="80:80"
new_text=`echo $port_line | awk '{print $2}'`
sed -i "s|$old_text|$new_text|" $docker_compose_file
echo "$port_line"


# container names are unique 

old_text="container_name: wordpress"
new_text="${old_text}_${site_name}"
sed -i "s|$old_text|$new_text|" $docker_compose_file

old_text="container_name: mysql"
new_text="${old_text}_${site_name}"
sed -i "s|$old_text|$new_text|" $docker_compose_file
