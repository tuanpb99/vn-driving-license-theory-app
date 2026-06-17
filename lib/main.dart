import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'core/network/api_client.dart';
import 'core/navigation/app_routes.dart';
import 'core/theme/theme.dart';
import 'data/repositories/question_repository.dart';
import 'data/services/question_api_service.dart';
import 'screens/exam/thi_thu_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/settings/settings_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const OtomotoApp());
}

class OtomotoApp extends StatelessWidget {
  const OtomotoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = AppTheme.dark;
    return Provider<QuestionRepository>(
      create: (_) => QuestionRepository(
        QuestionApiService(ApiClient.createDio()),
      ),
      child: MaterialApp(
        title: 'OTOMOTO - B',
        debugShowCheckedModeBanner: false,
        theme: base.copyWith(
          textTheme: GoogleFonts.interTextTheme(base.textTheme),
        ),
        routes: {
          AppRoutes.home: (_) => const HomeScreen(),
          AppRoutes.training: (_) => const ThiThuScreen(),
          AppRoutes.info: (_) => const SettingsScreen(),
        },
        initialRoute: AppRoutes.home,
      ),
    );
  }
}
