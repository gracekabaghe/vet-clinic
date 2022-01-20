/* Populate database with sample data. */

INSERT INTO animals (name) VALUES ('Luna');
INSERT INTO animals (name) VALUES ('Daisy');
INSERT INTO animals (name) VALUES ('Charlie');

INSERT INTO animals 
(name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Agumon', '3-2-2020', '0', 'true', '10.23');

INSERT INTO animals 
(name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Gabumon', '11-15-2018', '2', 'true', '8');

INSERT INTO animals 
(name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Pikachu', '01-07-2021', '1', 'false', '15.08');

INSERT INTO animals 
(name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Devimon', '05-12-2017', '5', 'true', '11');

-- Her name is Plantmon. She was born on Nov 15th, 2022, and currently weighs -5.7kg. She is neutered and she has tried to escape 2 times.

INSERT INTO animals 
(name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Charmander', '02-08-2020', '0', 'false', '11');

INSERT INTO animals 
(name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Plantmon', '11-15-2022', '2', 'true', '-5.7');

INSERT INTO animals 
(name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Squirtle', '04-02-1993', '3', 'false', '-12.13');

INSERT INTO animals 
(name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Angemon', '06-12-2005', '2', 'true', '-45');

INSERT INTO animals 
(name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Boarmon', '06-07-2005', '7', 'true', '20.4');

INSERT INTO animals 
(name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Blossom', '10-13-1998', '3', 'true', '17');

-- for owners table

INSERT INTO owners 
(full_name, age) 
VALUES ('Sam Smith', 34);

INSERT INTO owners 
(full_name, age) 
VALUES ('Jennifer Orwell', 19);

INSERT INTO owners 
(full_name, age) 
VALUES ('Bob', 45);

INSERT INTO owners 
(full_name, age) 
VALUES ('Melody Pond', 77);

INSERT INTO owners 
(full_name, age) 
VALUES ('Dean Winchester', 14);

INSERT INTO owners 
(full_name, age) 
VALUES ('Jodie Whittaker', 38);

-- species

INSERT INTO species 
(name) 
VALUES 
('Pokemon');

INSERT INTO species 
(name) 
VALUES 
('Digimon');

UPDATE animals 
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') 
WHERE name = 'Agumon';

UPDATE animals 
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') 
WHERE name = 'Pikachu';

UPDATE animals 
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') 
WHERE name = 'Gabumon';

-- Bob owns Devimon and Plantmon.

UPDATE animals 
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') 
WHERE name = 'Devimon';

UPDATE animals 
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') 
WHERE name = 'Plantmon';

-- Melody Pond owns Charmander, Squirtle, and Blossom.

UPDATE animals 
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') 
WHERE name = 'Charmander';

UPDATE animals 
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') 
WHERE name = 'Squirtle';

UPDATE animals 
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') 
WHERE name = 'Blossom';

-- Dean Winchester owns Angemon and Boarmon.

UPDATE animals 
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') 
WHERE name = 'Angemon';

UPDATE animals 
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') 
WHERE name = 'Boarmon';

-- Modify your inserted animals so it includes the species_id value:
-- If the name ends in "mon" it will be Digimon
-- All other animals are Pokemon

BEGIN;
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 1 WHERE species_id IS NULL ;
COMMIT;

-- insert vets

INSERT INTO vets 
(name, age, date_of_graduation) 
VALUES
    ('William Tatcher', 45, '2000-04-23'); 

INSERT INTO vets 
(name, age, date_of_graduation) 
VALUES
('Maisy Smith', 26, '2019-01-17');

INSERT INTO vets 
(name, age, date_of_graduation) 
VALUES
('Stephanie Mendez', 64, '04-05-1981');

INSERT INTO vets 
(name, age, date_of_graduation) 
VALUES
('Jack Harkness', 38, '08-06-2008');
