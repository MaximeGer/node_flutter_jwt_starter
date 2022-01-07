# JWT Authentication with Flutter, NodeJS and PostgreSQL

A project template to make a Flutter app linked to a NodeJS API with a JWT authentication.

## List of technologies used

- Flutter
  - go_router
- NodeJS
  - swagger
- PostgreSQL
- Docker

## Environment initialization

Copy/paste all the templates and rename them without the '.example' part:

- /api/.example.docker.env
- /api/.example.env
- /api/config/db_connect.example.js

## Install with docker

docker compose up --build

## Install manually

DB:

````shell
/db/scripts/init.sql
````

Api:

````shell
npm install
npm start
````

Flutter:

````shell
flutter pub get
flutter run
````
