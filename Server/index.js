const express = require("express");
const app = express();
const port = 3000;

// Basic express boilerplate code
app.get("/", (req, res) => {
  res.send("Hello World!");
});

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`);
});
