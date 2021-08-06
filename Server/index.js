const express = require("express");
const app = express();
const port = 3000;
const https = require("https");
require("dotenv").config();

// Basic express boilerplate code
app.use(express.json());
app.use(express.urlencoded());

app.get("/", (req, res) => {
  res.send("Hello World!");
});

app.listen(port, () => {
  console.log(
    `Hue Weather APP connected and listening at http://localhost:${port}. `
  );
});

// Open weather API
const weather = require("openweather-apis");
const axios = require("axios");
var conditions = "none";

axios({
  method: "GET",
  url: "https://api.openweathermap.org/data/2.5/weather",
  headers: {
    "content-type": "application/octet-stream",
  },
  params: {
    zip: 75149,
    appID: process.env.OPEN_WEATHER_API_KEY,
  },
})
  .then((response) => {
    console.log(
      `Current weather conditions from the API: ${response.data.weather[0].main}`
    );
    conditions = response.data.weather[0].main;
  })
  .catch((error) => {
    console.log(error);
  });
