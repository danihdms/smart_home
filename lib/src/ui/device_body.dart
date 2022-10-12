import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:smart_home/src/ui/device_screen.dart';

import '../models/item_model.dart';
import 'constants.dart';

class DeviceBody extends StatelessWidget {
  const DeviceBody({
    Key? key,
    required this.device,
  }) : super(key: key);

  final Device device;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget tmp;

    if (device.intensity != null) {
      tmp = LightBody(device: device);
    } else if (device.position != null) {
      tmp = RollerShutterBody(device: device);
    } else {
      tmp = HeaterBody(device: device);
    }

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          HeaderDevice(size: size, device: device),
          Text(
            device.deviceName,
            style: const TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.bold,
              color: kBrown,
            ),
          ),
          const SizedBox(
            height: kDefaultPadding * 3,
          ),
          tmp,
        ],
      ),
    );
  }
}

class LightBody extends DeviceBody {
  const LightBody({super.key, required super.device});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SleekCircularSlider(
          initialValue: device.intensity!.toDouble(),
          appearance: CircularSliderAppearance(
              size: MediaQuery.of(context).size.width * 0.35,
              infoProperties: InfoProperties(
                  bottomLabelText: 'Intensity',
                  bottomLabelStyle: const TextStyle(color: kBrown)),
              customColors: CustomSliderColors(
                shadowColor: kBrown,
                shadowMaxOpacity: 0.2,
                progressBarColors: [kBrown, kWhite],
                trackColor: kLightSteelBlue,
              )),
          onChange: (value) => Light.setIntensity(device, value.toInt()),
        ),
        LiteRollingSwitch(
          value: (device.mode == 'ON'),
          textOn: 'ON',
          textOff: 'OFF',
          colorOn: kBrown,
          colorOff: kBrown.withOpacity(0.23),
          iconOn: Icons.done,
          iconOff: Icons.blur_off,
          onSwipe: () {},
          onChanged: (mode) {
            if (mode) {
              device.mode = 'ON';
            } else {
              device.mode = 'OFF';
            }
          },
          onDoubleTap: () {},
          onTap: () {},
        )
      ],
    );
  }
}

class HeaterBody extends DeviceBody {
  const HeaterBody({super.key, required super.device});

  get rollerShutters => null;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SleekCircularSlider(
          initialValue: device.temperature!.toDouble(),
          min: 5,
          max: 28,
          appearance: CircularSliderAppearance(
              size: MediaQuery.of(context).size.width * 0.35,
              infoProperties: InfoProperties(
                  modifier: (percentage) {
                    final roundedValue = percentage.ceil().toInt().toString();
                    return '$roundedValue °C';
                  },
                  bottomLabelText: 'Temperature',
                  bottomLabelStyle: const TextStyle(color: kBrown)),
              customColors: CustomSliderColors(
                shadowColor: kBrown,
                shadowMaxOpacity: 0.2,
                progressBarColors: [kBrown, kWhite],
                trackColor: kLightSteelBlue,
              )),
          onChange: (value) => Heater.setTemperature(device, value.toInt()),
        ),
        LiteRollingSwitch(
          value: (device.mode == 'ON'),
          textOn: 'ON',
          textOff: 'OFF',
          colorOn: kBrown,
          colorOff: kBrown.withOpacity(0.23),
          iconOn: Icons.done,
          iconOff: Icons.blur_off,
          onSwipe: () {},
          onChanged: (mode) {
            if (mode) {
              device.mode = 'ON';
            } else {
              device.mode = 'OFF';
            }
          },
          onDoubleTap: () {},
          onTap: () {},
        )
      ],
    );
  }
}

class RollerShutterBody extends DeviceBody {
  const RollerShutterBody({super.key, required super.device});

  @override
  Widget build(BuildContext context) {
    String opened;

    if (device.position == 0) {
      opened = 'Closed';
    } else {
      opened = 'Opened at';
    }
    return Column(
      children: [
        SleekCircularSlider(
          initialValue: device.position!.toDouble(),
          appearance: CircularSliderAppearance(
              size: MediaQuery.of(context).size.width * 0.35,
              infoProperties: InfoProperties(
                  bottomLabelText: opened,
                  bottomLabelStyle: const TextStyle(color: kBrown)),
              customColors: CustomSliderColors(
                shadowColor: kBrown,
                shadowMaxOpacity: 0.2,
                progressBarColors: [kBrown, kWhite],
                trackColor: kLightSteelBlue,
              )),
          onChange: (value) => RollerShutter.setPosition(device, value.toInt()),
        ),
      ],
    );
  }
}

class HeaderDevice extends StatelessWidget {
  const HeaderDevice({
    Key? key,
    required this.size,
    required this.device,
  }) : super(key: key);

  final Size size;
  final Device device;

  @override
  Widget build(BuildContext context) {
    String img;
    if (device.intensity != null) {
      if (device.mode == 'ON') {
        img = 'assets/DeviceLightOnIcon.png';
      } else {
        img = 'assets/DeviceLightOffIcon.png';
      }
    } else if (device.temperature != null) {
      if (device.mode == 'ON') {
        img = 'assets/DeviceHeaterOnIcon.png';
      } else {
        img = 'assets/DeviceHeaterOffIcon.png';
      }
    } else {
      img = 'assets/DeviceRollerShutterIcon.png';
    }
    return Container(
      margin: const EdgeInsets.only(bottom: kDefaultPadding * 2.5),
      height: size.height * 0.2,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              left: kDefaultPadding,
              bottom: 36 + kDefaultPadding,
            ),
            height: size.height * 0.2 - 27,
            decoration: BoxDecoration(
              color: kBrown,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 10),
                  blurRadius: 50,
                  color: kLightSteelBlue.withOpacity(0.23),
                ),
              ],
            ),
            child: Center(
              child: SizedBox(
                height: 130,
                child: Image.asset(img),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
