import 'package:hive_flutter/hive_flutter.dart';

abstract class LocalStorageService {
  Future<void> init();
  Future<void> save(String key, dynamic value);
  dynamic read(String key);
  Future<void> delete(String key);
  Future<void> clear();
}

class LocalStorageServiceImpl implements LocalStorageService {
  late Box _box;
  static const String _boxName = 'car_360_storage';

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
  }

  @override
  Future<void> save(String key, dynamic value) async {
    await _box.put(key, value);
  }

  @override
  dynamic read(String key) {
    return _box.get(key);
  }

  @override
  Future<void> delete(String key) async {
    await _box.delete(key);
  }

  @override
  Future<void> clear() async {
    await _box.clear();
  }
}
