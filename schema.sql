/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

CREATE TABLE animals(
  id                INT GENERATED ALWAYS AS IDENTITY,
  name              VARCHAR(60),
  date_of_birth     DATE,
  escape_attempts   INT,
  neutered          BOOLEAN,
  weight_kg         DECIMAL,
  PRIMARY KEY(id)
);

ALTER TABLE animals
ADD species VARCHAR(60);

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(60),
    age INT
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(60)
);

ALTER TABLE animals
DROP COLUMN species;

-- add column species_id which is a foreign key referencing species table
ALTER TABLE animals
    ADD species_id INT, 
    ADD CONSTRAINT species_id
    FOREIGN KEY(species_id)
    REFERENCES species(id);

    -- Add column owner_id which is a foreign key referencing the owners table

    ALTER TABLE animals 
    ADD owners_id INT, 
    ADD CONSTRAINT owners_id 
    FOREIGN KEY(owners_id) 
    REFERENCES owners(id);

CREATE TABLE vets(
  id                 INT GENERATED ALWAYS AS IDENTITY,
  name               VARCHAR(60),
  age                INT,
  date_of_graduation DATE,
  PRIMARY KEY(id)
);

CREATE TABLE specializations (
    species_id INT,
    vets_id INT,
    CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id),
    CONSTRAINT fk_vets FOREIGN KEY(vets_id) REFERENCES vets(id)
);

CREATE TABLE visits (
    animals_id INT,
    vets_id INT,
    date_of_visit DATE,
    CONSTRAINT fk_animals FOREIGN KEY(animals_id) REFERENCES animals(id),
    CONSTRAINT fk_vets FOREIGN KEY(vets_id) REFERENCES vets(id)
);
    