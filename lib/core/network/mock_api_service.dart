import 'dart:convert';

import 'package:flutter/services.dart';

import '../constants/app_paths.dart';

class MockApiService {
  const MockApiService();

  Future<Map<String, dynamic>> fetchQuestionsPayload() async {
    final raw = await rootBundle.loadString(AppPaths.questionsSampleAsset);
    return json.decode(raw) as Map<String, dynamic>;
  }
}
