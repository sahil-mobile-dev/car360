import 'package:flutter/foundation.dart';
import 'package:car_360/main_dev.dart' as dev;
import 'package:car_360/main_prod.dart' as prod;

void main() {
  if (kDebugMode) {
    dev.main();
  } else {
    prod.main();
  }
}
