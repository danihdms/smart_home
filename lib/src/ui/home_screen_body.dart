import 'package:flutter/material.dart';
import 'package:smart_home/src/ui/constants.dart';
import 'package:smart_home/src/ui/device_screen.dart';
import '../blocs/devices_bloc.dart';
import '../models/item_model.dart';
import 'header_search_bar.dart';

class HomeScreenBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeScreenBodyState();
  }
}

class HomeScreenBodyState extends State<HomeScreenBody> {
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
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          HeaderSearchBar(size: size),
          StreamBuilder(
            stream: bloc.allDevices,
            builder: (context, AsyncSnapshot<ItemModel> snapshot) {
              if (snapshot.hasData) {
                return ListViewBuilder(
                  snapshot: snapshot,
                  devTypes: snapshot.data!.devTypes,
                  lights: snapshot.data!.lights,
                  heaters: snapshot.data!.heaters,
                  rollerShutters: snapshot.data!.rollerShutters,
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}

class ListViewBuilder extends StatelessWidget {
  const ListViewBuilder({
    Key? key,
    required this.snapshot,
    required this.devTypes,
    required this.lights,
    required this.heaters,
    required this.rollerShutters,
  }) : super(key: key);

  final AsyncSnapshot<ItemModel> snapshot;
  final List<String> devTypes;
  final List<Device> lights;
  final List<Device> heaters;
  final List<Device> rollerShutters;

  @override
  Widget build(BuildContext context) {
    int subDevCount;
    List<Device> tmp;
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: devTypes.length,
      itemBuilder: (BuildContext context, int index) {
        if (devTypes[index] == 'Light') {
          tmp = lights;
          subDevCount = lights.length;
        } else if (devTypes[index] == 'Heater') {
          tmp = heaters;
          subDevCount = heaters.length;
        } else {
          tmp = rollerShutters;
          subDevCount = rollerShutters.length;
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding),
              child: Text(
                devTypes[index],
                style: TextStyle(
                  shadows: <Shadow>[
                    Shadow(
                      offset: const Offset(10.0, 10.0),
                      blurRadius: 3.0,
                      color: kBrown.withOpacity(0.23),
                    ),
                  ],
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: kBrown,
                ),
              ),
            ),
            ListView.builder(
              itemCount: subDevCount,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int i) {
                return Container(
                  padding: const EdgeInsets.only(
                    left: kDefaultPadding * 2,
                    bottom: kDefaultPadding,
                    right: kDefaultPadding * 2,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      buildDevicePage(index, i, context);
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(100),
                        backgroundColor: kWhite),
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              tmp[i].deviceName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: kLightSteelBlue,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              (tmp[i].toString()),
                              style: const TextStyle(color: kLightSteelBlue),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> buildDevicePage(int index, int i, context) {
    List<Device> tmp;
    if (index == 0) {
      tmp = lights;
    } else if (index == 1) {
      tmp = rollerShutters;
    } else {
      tmp = heaters;
    }
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DeviceScreen(
          device: tmp[i],
        ),
      ),
    );
  }
}
