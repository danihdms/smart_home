import 'package:flutter/material.dart';
import 'package:smart_home/src/ui/home_screen.dart';
import '../models/item_model.dart';
import 'constants.dart';
import 'device_body.dart';

class DeviceScreen extends StatelessWidget {
  const DeviceScreen({
    Key? key,
    required this.device,
  }) : super(key: key);

  final Device device;

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
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return const HomeScreen();
            }));
          }),
    );
  }
}
