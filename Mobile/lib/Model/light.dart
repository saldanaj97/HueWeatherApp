class Light {
  final int id;
  final LightInfo lightInfo;

  Light(this.id, this.lightInfo);
}

class LightInfo {
  LightState state = LightState();
  String type = '';
  String name = '';
  String uniqueID = '';
  String productName = '';
}

class LightState {
  bool on = false;
  int bri = 0;
  int hue = 0;
  int sat = 0;
  String effect = '';
}
