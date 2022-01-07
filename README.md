# flutter_jwt_authentication

## Initialization

copy/paste all the templates and rename them without the '.example' part:

- /api/.example.docker.env
- /api/.example.env
- /api/config/db_connect.example.js

## Install with docker

docker compose up --build

## Install Manually

Api:

````shell
npm install
npm start
````

DB:

````shell
/db/scripts/init.sql
````

Flutter:

````shell
flutter pub get
flutter run
````
