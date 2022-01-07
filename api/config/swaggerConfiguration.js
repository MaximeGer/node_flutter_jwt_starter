const jsDoc = {
  swaggerDefinition: {
    openapi: "3.0.0",
    info: {
      title: "Workout API",
      version: "1.0.0",
    },
    servers: [{ url: "/v1/api" }],
    components: {
      securitySchemes: {
        ApiKey: {
          type: "apiKey",
          name: process.env.API_KEY_NAME,
          in: "header",
        },
        JwtToken: {
          type: "http",
          scheme: "bearer",
          bearerFormat: "JWT"
        }
      },
    },
  },
  apis: [
    "routes/users.js",
    "routes/cities.js"
  ],
};
const UIOptions = {
  customCss: ".swagger-ui .topbar { display: none }",
  customSiteTitle: "Cities API",
  swaggerOptions: {
    url: "http://localhost:3000",
    defaultModelsExpandDepth: -1,
  },
};
module.exports = { jsDoc, UIOptions };
