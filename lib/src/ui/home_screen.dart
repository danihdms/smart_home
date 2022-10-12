import 'package:flutter/material.dart';
import 'package:smart_home/src/ui/constants.dart';

import '../models/item_model.dart';
import 'home_screen_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.user,
    required this.lights,
    required this.heaters,
    required this.rollerShutters,
    required this.devTypes,
  });

  final User user;
  final List<String> devTypes;
  final List<Device> lights;
  final List<Device> heaters;
  final List<Device> rollerShutters;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: HomeScreenBody(
        devTypes: devTypes,
        lights: lights,
        heaters: heaters,
        rollerShutters: rollerShutters,
        user: user,
      ),
    );
  }

  static AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: kBrown,
      leading: Image.asset('assets/AppIcon.appiconset/120-removebg.png'),
    );
  }
}
