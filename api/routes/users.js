var express = require("express");
var router = express.Router();
const pool = require("../config/db_connect");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

/**
 * @swagger
 * components:
 *   schemas:
 *     User:
 *       type: object
 *       required:
 *         - email
 *       properties:
 *         id:
 *           type: integer
 *           description: identifier of the user
 *         email:
 *           type: string
 *           description: email of the user
 *         password:
 *           type: string
 *           description: password hash of the user
 */

/**
 * @swagger
 * tags:
 *   name: Users
 *   description: Manage the users
 */

/**
 * @swagger
 * /auth/login:
 *   post:
 *     summary: Returns the list of all the users
 *     tags: [Users]
 *     security:
 *       - ApiKey: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/User'
 *     responses:
 *       200:
 *         description: The list of the users
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/User'
 *
 */
router.post("/login", function (req, res, next) {
  pool.query(
    "SELECT id, email, password FROM users WHERE email = $1",
    [req.body.email],
    (error, results) => {
      if (error) {
        throw error;
      }
      if (results.rows.length < 1) {
        return res.status(400).json({ message: "Wrong Email" });
      }
      let user = results.rows[0];
      bcrypt.compare(req.body.password, user.password, (err, result) => {
        if (err) {
          console.log(err);
          return res.status(401).json({
            error: "Unauthorized",
            code: 401,
          });
        } else if (!result)
          return res.status(401).json({
            error: "Unauthorized",
            code: 401,
          });
        else {
          jwt.sign({ id: user.id }, process.env.SECRET_KEY, { expiresIn: "7d" }, (err, token) => {
            if (err) {
              console.log(err);
              return res.status(500).json({
                error: "Internal Server Error",
                code: 500,
              });
            } else
              return res.status(200).json({
                user: { email: user.email },
                token,
              });
          });
        }
      });
    }
  );
});

/**
 * @swagger
 * /auth/sign-in:
 *  post:
 *    summary: Creates a user
 *    tags: [Users]
 *    security:
 *      - ApiKey: []
 *    requestBody:
 *      required: true
 *      content:
 *        application/json:
 *          schema:
 *            $ref: '#/components/schemas/User'
 *    responses:
 *      201:
 *        description: The user is created
 *        content:
 *          application/json:
 *            schema:
 *              $ref: '#/components/schemas/User'
 */
router.post("/sign-in", function (req, res, next) {
  bcrypt.hash(req.body.password, bcrypt.genSalt(6), (err, hash) => {
    pool.query(
      "INSERT INTO users(email, password) VALUES ($1, $2) RETURNING *",
      [req.body.email, hash],
      (error, results) => {
        if (error) {
          if (error.message.includes("duplicate key")) {
            return res.status(400).json({ message: "This email is already used", });
          }
          
          throw error;
        }
        return res.status(201).json(results.rows);
      }
    );
  });
});

module.exports = router;
