CREATE DATABASE lab_db ENCODING 'UTF8' TEMPLATE template0;
CREATE USER labapp WITH ENCRYPTED PASSWORD '123';
GRANT ALL PRIVILEGES ON DATABASE lab_db TO labapp;