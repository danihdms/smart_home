import 'package:flutter/material.dart';
import 'package:smart_home/src/ui/home_screen_body.dart';
import 'package:smart_home/src/ui/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: HomeScreenBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: kBrown,
      leading: Image.asset('assets/AppIcon.appiconset/120-removebg.png'),
    );
  }
}
