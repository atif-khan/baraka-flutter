import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/core/di/injection.dart';

void main() async {
  // Set up dependency injection
  await configureDependencies();

  runApp(const MyApp());
}
