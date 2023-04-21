#!/bin/bash
set -ex
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -sc)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install postgresql-12 -y
sudo systemctl start postgresql@12-main
sudo -u postgres psql -f ./init.sql
pip install -r requirements.txt
python manage.py makemigrations
python manage.py migrate
python manage.py collectstatic --no-input

