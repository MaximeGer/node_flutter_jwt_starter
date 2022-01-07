const jwt = require("jsonwebtoken");

exports.authToken = (req, res, next) => {
  const { authorization } = req.headers;
  const token = authorization && authorization.split(" ")[1];
  if (token == null) {
    return res.status(401).json({
      error: "Unauthorized",
      code: 401,
    });
  }
  jwt.verify(token, process.env.SECRET_KEY, (err, user) => {
    if (err) {
      return res.status(403).json({
        error: "Forbidden",
        code: 403,
      });
    }
    req.user = user;
    next();
  });
};

exports.authKey = (req, res, next) => {
  if (
    req.headers[process.env.API_KEY_NAME] === "undefined" ||
    req.headers[process.env.API_KEY_NAME] !== process.env.API_KEY
  ) {
    return res.status(401).json({
      error: "Unauthorized",
      code: 401,
    });
  } else {
    return next();
  }
};
