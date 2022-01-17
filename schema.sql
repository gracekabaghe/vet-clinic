/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

\c vet_clinic

vet_clinic=# CREATE TABLE animals(
vet_clinic(#   id            INT,
vet_clinic(#   name    VARCHAR(250),
vet_clinic(#   date_of_birth           date,
vet_clinic(#   escape_attempts    INT,
vet_clinic(#   neutered     boolean,
vet_clinic(# weight INT,
vet_clinic(#   PRIMARY KEY(id)
vet_clinic(# );
