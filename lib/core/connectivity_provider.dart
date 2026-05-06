import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectivityProvider = StreamProvider<bool>((ref) async* {
  final connectivity = Connectivity();
  final initial = await connectivity.checkConnectivity();
  yield initial != ConnectivityResult.none;

  await for (final state in connectivity.onConnectivityChanged) {
    yield state != ConnectivityResult.none;
  }
});
