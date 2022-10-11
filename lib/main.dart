import 'package:flutter/material.dart';
import 'package:smart_home/src/ui/constants.dart';
import 'package:smart_home/src/ui/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Home',
      theme: ThemeData(
        scaffoldBackgroundColor: kWhite,
        primaryColor: kLightSteelBlue,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kDarkGray),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}
