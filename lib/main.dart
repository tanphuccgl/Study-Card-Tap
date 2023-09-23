import 'package:cardtap/src/locator.dart';
import 'package:flutter/material.dart';

import 'src/app.dart';

Future main() async {
  await ConfigApp.initializeApp();
  runApp(const MyApp());
}
