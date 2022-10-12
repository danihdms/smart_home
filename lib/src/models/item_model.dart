class ItemModel {
  late List<Device> _devices;
  late User _user;
  late final List<String> _devTypes = getDeviceTypes(_devices);
  late final List<Device> _lights = getLights(_devices);
  late final List<Device> _heaters = getHeaters(_devices);
  late final List<Device> _rollerShutters = getRollerShutters(_devices);

  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    List<Device> tmp = [];
    for (int i = 0; i < parsedJson['devices'].length; i++) {
      Device device = Device(parsedJson['devices'][i]);
      tmp.add(device);
    }
    _devices = tmp;
    _user = User(parsedJson['user']);
  }

  List<Device> get devices => _devices;
  User get user => _user;
  List<String> get devTypes => _devTypes;
  List<Device> get lights => _lights;
  List<Device> get heaters => _heaters;
  List<Device> get rollerShutters => _rollerShutters;

  List<String> getDeviceTypes(List<Device> devices) {
    List<String> types = [];
    for (int i = 0; i < devices.length; i++) {
      if (!types.contains(devices[i]._productType)) {
        types.add(devices[i]._productType);
      }
    }
    return types;
  }

  List<Device> getLights(List<Device> devices) {
    List<Device> lights = [];
    for (int i = 0; i < devices.length; i++) {
      if (devices[i]._productType == 'Light') {
        lights.add(devices[i]);
      }
    }
    return lights;
  }

  List<Device> getHeaters(List<Device> devices) {
    List<Device> heaters = [];
    for (int i = 0; i < devices.length; i++) {
      if (devices[i]._productType == 'Heater') {
        heaters.add(devices[i]);
      }
    }
    return heaters;
  }

  List<Device> getRollerShutters(List<Device> devices) {
    List<Device> rollerShutters = [];
    for (int i = 0; i < devices.length; i++) {
      if (devices[i]._productType == 'RollerShutter') {
        rollerShutters.add(devices[i]);
      }
    }
    return rollerShutters;
  }
}

class Device {
  late int _id;
  late String _deviceName;
  late String _productType;

  late int? _intensity;
  late String? _mode;

  late int? _position;

  late int? _temperature;

  Device(device) {
    _id = device['id'];
    _deviceName = device['deviceName'];
    _productType = device['productType'];
    _intensity = device['intensity'];
    _mode = device['mode'];
    _position = device['position'];
    _temperature = device['temperature'];
  }

  int get id => _id;
  String get deviceName => _deviceName;
  String get productType => _productType;
  int? get intensity => _intensity;
  int? get position => _position;
  String? get mode => _mode;
  int? get temperature => _temperature;

  set mode(value) {
    _mode = value;
  }

  @override
  String toString() {
    if (intensity != null) {
      return Light.printAtt(this);
    } else if (position != null) {
      return RollerShutter.printAtt(this);
    } else {
      return Heater.printAtt(this);
    }
  }
}

class Light extends Device {
  Light(light) : super(light);

  static void setIntensity(Device device, int intensity) {
    if (intensity == 0) {
      device._intensity = 0;
      setMode(device, 'OFF');
    } else if (intensity == 100) {
      setMode(device, 'ON');
      device._intensity = 100;
    } else {
      setMode(device, 'ON');
      device._intensity = intensity + 1;
    }
  }

  static void setMode(Device device, String mode) {
    device._mode = mode;
  }

  static String printAtt(Device dev) {
    return '${dev.mode} - Intensity : ${dev.intensity}';
  }
}

class RollerShutter extends Device {
  RollerShutter(rollerShutter) : super(rollerShutter);

  static void setPosition(Device device, int position) {
    if (position >= 100) {
      device._position = 100;
    } else {
      if (position == 0) {
        device._position = 0;
      } else {
        device._position = position + 1;
      }
    }
  }

  static String printAtt(Device device) {
    if (device.position == 0) {
      return 'Closed';
    } else if (device.position == 100) {
      return 'Opened';
    } else {
      return 'Opened at ${device.position}%';
    }
  }
}

class Heater extends Device {
  Heater(heater) : super(heater);

  static void setTemperature(Device device, int temperature) {
    if (device._temperature! <= 27) {
      device._temperature = temperature + 1;
    } else {
      device._temperature = 28;
    }
    if (temperature > 5 && device._mode == 'ON') {
      setMode(device, 'ON');
    } else {
      setMode(device, 'OFF');
    }
  }

  static void setMode(Device device, String mode) {
    device._mode = mode;
  }

  static String printAtt(Device device) {
    if (device.mode == 'ON') {
      return '${device.mode} at ${device.temperature}°C';
    } else {
      return '${device.mode}';
    }
  }
}

class User {
  late String _firstName;
  late String _lastName;
  late Address _address;
  late int _birthDate;

  User(user) {
    _firstName = user['firstName'];
    _lastName = user['lastName'];
    _address = Address(user['address']);
    _birthDate = user['birthDate'];
  }

  String get firstName => _firstName;
  String get lastName => _lastName;
  Address get address => _address;
  int get birthDate => _birthDate;
}

class Address {
  late String _city;
  late int _postalCode;
  late String _street;
  late String _streetCode;
  late String _country;

  Address(address) {
    _city = address['city'];
    _postalCode = address['postalCode'];
    _street = address['street'];
    _streetCode = address['streetCode'];
    _country = address['country'];
  }

  String get city => _city;
  int get postalCode => _postalCode;
  String get street => _street;
  String get streetCode => _streetCode;
  String get country => _country;
}
