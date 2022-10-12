import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model.dart';

class DeviceApiProvider {
  Client client = Client();

  Future<ItemModel> fetchDevicesList() async {
    final response = await client
        .get(Uri.parse("http://storage42.com/modulotest/data.json"));
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load devices');
    }
  }
}
