import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/di/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      overrides: [
        bootstrapProvider.overrideWithValue(const AppBootstrapState()),
      ],
      child: const DrivingTheoryApp(),
    ),
  );
}
