/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name = 'Luna';

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '01-01-2016' AND '01-12-2019';
SELECT name FROM animals WHERE neutered='true' AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pickachu';
SELECT name,escape_attempts FROM animals WHERE weight_Kg > 10.5;
SELECT * FROM animals WHERE neutered='true';
SELECT * FROM animals WHERE NOT name='Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

BEGIN;
UPDATE animals SET species = 'Digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'Pokemon' WHERE species IS NULL;
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-1-1';
SAVEPOINT delete_one;
UPDATE animals SET weight_kg = -1 * weight_kg;
ROLLBACK TO delete_one;
UPDATE animals SET weight_kg = -1 * weight_kg WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
-- 9

SELECT COUNT(*) FROM animals WHERE neutered = false;
-- 3

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
-- 2

SELECT AVG(weight_kg) FROM animals;
-- 16.6488888888888889

SELECT MAX(escape_attempts) FROM animals;
-- 7

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth >= '01-01-1990' AND date_of_birth < '12-31-2000' GROUP BY species;

-- What animals belong to Melody Pond?

SELECT animals.name FROM animals 
JOIN owners ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).

SELECT animals.*, species.name AS species_name FROM animals 
JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.

SELECT animals.name AS animal_name, owners.fulL_name AS owner_name FROM owners 
LEFT JOIN animals ON owners.id = animals.owner_id;

-- How many animals are there per species?

SELECT species.name, COUNT(*) FROM animals 
JOIN species ON species.id = animals.species_id GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.

SELECT animals.name AS animal_name, owners.full_name AS owner_name, species.name AS species_name FROM animals
JOIN species ON species.id = animals.species_id JOIN owners ON owners.id = animals.owner_id WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';
-- List all animals owned by Dean Winchester that haven't tried to escape.

SELECT * FROM animals
JOIN owners ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;
-- Who owns the most animals?
SELECT owners.full_name, COUNT(animals.name) AS num_animals FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY num_animals DESC;
