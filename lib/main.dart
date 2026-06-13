import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/di/injection_container.dart' as di;
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'core/services/app_snackbar.dart';
import 'core/services/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ── System UI ───────────────────────────────────────────────────────────
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // ── Dependency Injection ────────────────────────────────────────────────
  await di.initDependencies();

  runApp(const ServiceApp());
}

class ServiceApp extends StatelessWidget {
  const ServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Service App',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: LocalStorage.hasToken() ? AppRoutes.dashboard : AppRoutes.signIn,
      routes: AppRoutes.routes,
    );
  }
}
