import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';

class DeviceBloc {
  final _repository = Repository();
  final _devicesFetcher = PublishSubject<ItemModel>();

  Stream<ItemModel> get allDevices => _devicesFetcher.stream;

  fetchAllDevices() async {
    ItemModel itemModel = await _repository.fetchAllDevices();
    _devicesFetcher.sink.add(itemModel);
  }

  dispose() {
    _devicesFetcher.close();
  }
}

final bloc = DeviceBloc();
