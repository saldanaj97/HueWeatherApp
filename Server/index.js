const express = require("express");
const app = express();
const port = 3000;
const axios = require("axios");
const v3 = require("node-hue-api");
require("dotenv").config();

app.use(express.json());

app.get("/", (req, res) => {
  res.send("Hello World!");
});

app.listen(port, () => {
  console.log(
    `Hue Weather APP connected and listening at http://localhost:${port}. `
  );
});

// Variable to hold the current weather conditions in the request below
var currentConditions = "none";
app.get("/conditions/:lat/:long", (req, res) => {
  axios({
    method: "GET",
    url: "https://api.openweathermap.org/data/2.5/weather",
    headers: {
      "content-type": "application/octet-stream",
    },
    params: {
      lat: req.params.lat,
      lon: req.params.long,
      appID: process.env.OPEN_WEATHER_API_KEY,
    },
  })
    .then((response) => {
      console.log(
        `Current weather conditions from the openWeather API: ${response.data}`
      );
      currentConditions = response.data;
    })
    .catch((error) => {
      console.log(error);
    });
  res.send(currentConditions);
});

// Hue API
app.get("/bridges", (req, res) => {
  v3.discovery
    .nupnpSearch()
    .then((searchResults) => {
      const hostBridge = "192.168.1.150"; //TODO: Change to user selected host address from a DB later on
      return v3.api.createLocal(hostBridge).connect(process.env.HUE_USERNAME);
    })
    .then((api) => {
      return api.lights.getAll();
    })
    .then((allLights) => {
      var lights = [];
      allLights.forEach((light) => {
        lights.push(light.data);
      });
      res.send(lights);
    })
    .catch((err) => {
      console.log("Error with gathering light and bridge info. " + err);
    });
});

app.get("/sync", (req, res) => {
  res.send("Syncing light with the weather. ");
});
