import 'package:flutter/material.dart';
import 'package:smart_home/src/ui/home_screen.dart';
import '../models/item_model.dart';
import 'constants.dart';
import 'device_body.dart';

class DeviceScreen extends StatelessWidget {
  const DeviceScreen({
    Key? key,
    required this.user,
    required this.device,
    required this.devTypes,
    required this.lights,
    required this.heaters,
    required this.rollerShutters,
  }) : super(key: key);

  final User user;
  final Device device;
  final List<String> devTypes;
  final List<Device> lights;
  final List<Device> heaters;
  final List<Device> rollerShutters;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: DeviceBody(
        device: device,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: kBrown,
      leading: IconButton(
        icon: Image.asset('assets/back_arrow.png'),
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return HomeScreen(
              devTypes: devTypes,
              lights: lights,
              heaters: heaters,
              rollerShutters: rollerShutters,
              user: user,
            );
          }));
        },
      ),
    );
  }
}
