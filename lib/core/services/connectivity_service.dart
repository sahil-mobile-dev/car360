import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityService {
  Stream<bool> get onConnectivityChanged;
  Future<bool> get isConnected;
}

class ConnectivityServiceImpl implements ConnectivityService {

  ConnectivityServiceImpl() {
    _connectivity.onConnectivityChanged.listen((results) {
      // connectivity_plus 6.0+ returns List<ConnectivityResult>
      final isConnected = results.any(
        (result) => result != ConnectivityResult.none,
      );
      _controller.add(isConnected);
    });
  }
  final Connectivity _connectivity = Connectivity();
  final _controller = StreamController<bool>.broadcast();

  @override
  Stream<bool> get onConnectivityChanged => _controller.stream;

  @override
  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    return results.any((result) => result != ConnectivityResult.none);
  }
}
