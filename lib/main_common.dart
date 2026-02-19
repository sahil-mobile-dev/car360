import 'package:car_360/app.dart';
import 'package:car_360/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> mainCommon(String envFile) async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: envFile);

  final container = ProviderContainer();
  await container.read(localStorageServiceProvider).init();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}
