const express = require("express");
const app = express();
const port = 3000;
require("dotenv").config();

// Basic express boilerplate code
app.get("/", (req, res) => {
  res.send("Hello World!");
});

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`);
});

// Open weather API
const weather = require("openweather-apis");

weather.setLang("en");
weather.setZipCode(75149);
weather.setUnits("metric");
weather.setAPPID(process.env.OPEN_WEATHER_API_KEY);

weather.getDescription(function (err, desc) {
  if (err) {
    console.log(err);
  }
  console.log(desc);
});
