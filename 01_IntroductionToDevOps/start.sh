#!/bin/bash
set -ex
#sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -sc)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
#wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
#sudo apt-get update
#sudo apt-get install postgresql-12 -y
#sudo systemctl start postgresql@12-main
#sudo -u postgres psql -f ./init.sql
#docker run -d --name postgre --network=net1 -p 5432:5432 -v $(pwd)/sql:/sql -e POSTGRES_PASSWORD=123 postgres:12
#docker exec -it postgre psql --username postgres -f /sql/init.sql
#python3.8 -m venv myvenv
#source myenv/bin/activate
# pip install --upgrade pip
# pip install -r requirements.txt
python manage.py makemigrations
python manage.py migrate
python manage.py collectstatic --no-input
./chekuser.sh
python manage.py runserver 0.0.0.0:8000
#ss -ntpl
#curl localhost:8000

