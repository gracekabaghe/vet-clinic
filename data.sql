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

-- specializations

INSERT INTO specializations (
    species_id,
    vets_id
    ) VALUES
    (1, 1),
    (1, 3),
    (2, 3),
    (2, 4);

    -- animal visits

INSERT INTO visits 
(animals_id, vets_id, date_of_visit) 
VALUES

    ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-5-24'),
    ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-7-22'),
    ((SELECT id FROM animals WHERE name = 'Gabumon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-2-2'),
    ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-1-5'),
    ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-3-8'),
    ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-5-14'),
    ((SELECT id FROM animals WHERE name = 'Devimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2021-5-4'),
    ((SELECT id FROM animals WHERE name = 'Charmander'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-2-24'),
    ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-12-21'),
    ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-8-10'),
    ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2021-4-7'),
    ((SELECT id FROM animals WHERE name = 'Squirtle'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2019-9-29'),
    ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-10-3'),
    ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-11-4'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-1-24'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-5-15'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-2-27'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-8-3'),
    ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-5-24'),
    ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2021-1-11');
