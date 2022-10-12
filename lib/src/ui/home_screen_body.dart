import 'package:flutter/material.dart';
import '../models/item_model.dart';
import 'constants.dart';
import 'device_screen.dart';
import 'header_search_bar.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({
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
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          HeaderSearchBar(
            size: size,
            user: user,
          ),
          ListViewBuilder(
            user: user,
            devTypes: devTypes,
            lights: lights,
            heaters: heaters,
            rollerShutters: rollerShutters,
          ),
        ],
      ),
    );
  }
}

class ListViewBuilder extends StatelessWidget {
  const ListViewBuilder({
    Key? key,
    required this.user,
    required this.devTypes,
    required this.lights,
    required this.heaters,
    required this.rollerShutters,
  }) : super(key: key);

  final User user;
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
          user: user,
          device: tmp[i],
          heaters: heaters,
          lights: lights,
          rollerShutters: rollerShutters,
          devTypes: devTypes,
        ),
      ),
    );
  }
}
