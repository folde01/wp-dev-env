#!/usr/bin/env bash

site_name="$1"
docker_vol_dir="docker-volumes"
docker_compose_dir="docker-compose"
docker_compose_template="templates/docker-compose.yml"

mkdir $docker_vol_dir/wordpress_db/$site_name
mkdir $docker_vol_dir/wordpress_files/$site_name

mkdir $docker_compose_dir/$site_name
cp $docker_compose_dir/$docker_compose_template $docker_compose_dir/$site_name/docker-compose.yml

# then change the site's docker-compose.yml so that:
#   * volume paths end with $site_name
#   * site has a unique network port
#   * the container names are unique 
