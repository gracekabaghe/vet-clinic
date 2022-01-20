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

-- Who was the last animal seen by William Tatcher?

SELECT animals.name, vets.name, visits.date_of_visit FROM vets
JOIN visits ON vets.id = visits.vets_id
JOIN animals ON animals.id = visits.animals_id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_visit DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?

SELECT COUNT(*) AS num_animals_visited FROM vets
	JOIN visits ON vets.id = visits.vets_id
	WHERE vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.

SELECT 
	vets.name,
	species.name AS specialized_in
FROM vets
LEFT JOIN specializations ON specializations.vets_id = vets.id
LEFT JOIN  species ON specializations.species_id = species.id;
-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.

SELECT animals.name AS animal_name, visits.date_of_visit FROM animals
JOIN visits ON visits.animals_id = animals.id
JOIN vets ON vets.id = visits.vets_id
WHERE vets.name = 'Stephanie Mendez' AND visits.date_of_visit >= '2020-04-01' AND visits.date_of_visit <= '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name, COUNT(*) AS count FROM animals
JOIN visits ON visits.animals_id = animals.id
GROUP BY animals.name
ORDER BY count DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT vets.name, visits.date_of_visit, animals.name FROM visits 
JOIN vets ON vets.id = visits.vets_id
JOIN animals ON animals.id = visits.animals_id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.date_of_visit
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.

SELECT
	date_of_visit,
	animals.date_of_birth AS animal_dob,
	animals.escape_attempts,
	animals.neutered,
	animals.weight_kg AS animal_weight,
	vets.name AS vet_name,
	vets.age AS vet_age,
	vets.date_of_graduation
from visits
JOIN animals ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
ORDER BY date_of_visit
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species? 8

SELECT COUNT(*)
FROM visits
JOIN animals ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vets_id
JOIN specializations ON specializations.vets_id = visits.vets_id
WHERE animals.species_id != specializations.species_id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most. Digimon

SELECT species.name AS species, COUNT(*) FROM visits
JOIN vets ON vets.id = visits.vets_id
JOIN animals ON animals.id = visits.animals_id
JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name;
