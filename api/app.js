require("dotenv").config(); // .env Import

// NodeModules Imports
const express = require("express");
const cookieParser = require("cookie-parser");
const logger = require("morgan");
const helmet = require("helmet");
const swaggerJsDoc = require("swagger-jsdoc");
const swaggerUI = require("swagger-ui-express");
const rateLimit = require("express-rate-limit");

// Routes Imports
const usersRouter = require("./routes/users");
const citiesRouter = require("./routes/cities");

// Authentication handler Imports
const auth = require("./middleware/auth").authKey;
const jwt = require("./middleware/auth").authToken;

// Swagger configuration Import
const swaggerConf = require("./config/swaggerConfiguration");

const app = express(); // Express initialized

// Modules Usage
app.use(logger("dev")); // level of log
app.use(express.json()); // JSON request/response normalization
app.use(express.urlencoded({ extended: false })); // Permits reading Body from requests
app.use(cookieParser()); // Permits reading cookies from requests
app.use(helmet()); // Prevents HTTP Headers attacks
app.use(rateLimit({ // Prevents DDoS attacks
  windowMs: 1000, // in second
  max: 10, // limit each IP to max requests per windowMs
}))

// Routes Application
app.use("/v1/api/auth", auth, usersRouter);
app.use("/v1/api/cities", jwt, citiesRouter);
app.use(
  "/v1/doc",
  swaggerUI.serve,
  swaggerUI.setup(swaggerJsDoc(swaggerConf.jsDoc), swaggerConf.UIOptions)
);

// Express Start
app.listen(3000, () => {
  console.log("App running");
});
