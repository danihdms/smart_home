import 'dart:async';
import 'devices_api_provider.dart';
import '../models/item_model.dart';

class Repository {
  final deviceApiProvider = DeviceApiProvider();

  Future<ItemModel> fetchAllDevices() => deviceApiProvider.fetchDevicesList();
}
