import 'package:flutter/material.dart';
import '../blocs/devices_bloc.dart';
import '../models/item_model.dart';
import 'home_screen.dart';

class UsefulInfo extends StatefulWidget {
  const UsefulInfo({super.key});

  @override
  State<StatefulWidget> createState() {
    return UsefulInfoState();
  }
}

class UsefulInfoState extends State<UsefulInfo> {
  @override
  void initState() {
    super.initState();
    bloc.fetchAllDevices();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.allDevices,
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (snapshot.hasData) {
          return HomeScreen(
            devTypes: snapshot.data!.devTypes,
            lights: snapshot.data!.lights,
            heaters: snapshot.data!.heaters,
            rollerShutters: snapshot.data!.rollerShutters,
            user: snapshot.data!.user,
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
