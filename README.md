I Don't Work!!!!

====================================================





CREATE DATABASE hair_salon

\c hair_salon

CREATE TABLE stylist (id serial PRIMARY KEY, name varchar);

CREATE TABLE client (id serial PRIMARY KEY, name varchar, stylist_id int);

CREATE DATABASE hair_salon_test WITH TEMPLATE hair_salon;

---------------------------------------------------------

contact

you can contact me at codybousc@gmail for more non-functioning web apps!
