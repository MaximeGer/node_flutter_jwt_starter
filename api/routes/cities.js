var express = require("express");
var router = express.Router();
const pool = require("../config/db_connect");

/**
 * @swagger
 * components:
 *   schemas:
 *     City:
 *       type: object
 *       required:
 *         - name
 *         - description
 *       properties:
 *         id:
 *           type: integer
 *           description: identifier of the City
 *         name:
 *           type: string
 *           description: name of the City
 */

/**
 * @swagger
 * tags:
 *   name: Cities
 *   description: Manage the Cities
 */

/**
 * @swagger
 * /Cities:
 *   get:
 *     summary: Returns the list of all the Cities
 *     tags: [Cities]
 *     security:
 *       - JwtToken: []
 *     responses:
 *       200:
 *         description: The list of the Cities
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/City'
 *
 */
router.get("/", function (req, res, next) {
  pool.query("SELECT id, name FROM Cities ORDER BY id ASC", (error, results) => {
    if (error) {
      throw error;
    }
    return res.status(200).json(results.rows);
  });
});


module.exports = router;
