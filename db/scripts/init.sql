CREATE TABLE "users" (
  "id" SERIAL PRIMARY KEY,
  "email" varchar(50) UNIQUE NOT NULL,
  "password" varchar(72) NOT NULL
);

CREATE TABLE "cities" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar(50) UNIQUE NOT NULL
);

---------------- INSERTION OF DEFAULT DATA ----------------
COPY cities("name")
FROM
  '/data/cities.csv' DELIMITER ';' CSV;
