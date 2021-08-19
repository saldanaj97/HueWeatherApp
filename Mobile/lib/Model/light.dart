class Light {
  final String id;
  final LightInfo lightInfo;

  Light(this.id, this.lightInfo);
}

class LightInfo {
  final LightState state;
  final String type;
  final String name;
  final String uniqueID;

  LightInfo(this.state, this.type, this.name, this.uniqueID);
}

class LightState {
  final bool on;
  final int bri;
  final int hue;
  final int sat;
  final String effect;

  LightState(this.on, this.bri, this.hue, this.sat, this.effect);
}
