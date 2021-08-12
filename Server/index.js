const express = require("express");
const app = express();
const port = 3000;
const axios = require("axios");
require("dotenv").config();

// Variable to hold the current weather conditions
var currentConditions = "none";

app.use(express.json());

app.get("/", (req, res) => {
  res.send("Hello World!");
});

app.listen(port, () => {
  console.log(
    `Hue Weather APP connected and listening at http://localhost:${port}. `
  );
});

var getWeatherRequest = axios({
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
    currentConditions = response.data.weather[0].main;
  })
  .catch((error) => {
    console.log(error);
  });

app.get("/conditions", (getWeatherRequest, res) => {
  res.send(currentConditions);
});
