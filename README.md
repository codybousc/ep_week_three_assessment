CREATE DATABASE hair_salon
\c hair_salon
CREATE TABLE stylist (id serial PRIMARY KEY, stylist_name varchar);
CREATE TABLE client (id serial PRIMARY KEY, client_name varchar, stylist_id int);
CREATE DATABASE hair_salon_test WITH TEMPLATE hair_salon;
