class Light {
  int id;
  LightInfo lightInfo;
  LightState lightState;

  Light(this.id, this.lightInfo, this.lightState);
}

class LightInfo {
  String type = '';
  String name = '';
  String uniqueID = '';
  String productName = '';

  LightInfo(this.type, this.name, this.uniqueID, this.productName);
}

class LightState {
  bool on = false;
  int bri = 0;
  int hue = 0;
  int sat = 0;
  String effect = '';
  double x = 0.0;
  double y = 0.0;

  LightState(this.on, this.bri, this.hue, this.sat, this.effect, this.x, this.y);
}
