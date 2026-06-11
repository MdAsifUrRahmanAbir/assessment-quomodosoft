import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'presentation/screens/sign_in/sign_in_screen.dart';
import 'presentation/screens/dashboard/dashboard_screen.dart';
import 'presentation/screens/service_list/service_list_screen.dart';
import 'presentation/screens/service_details/service_details_screen.dart';
import 'presentation/screens/create_service/create_service_screen.dart';
import 'presentation/screens/update_service/update_service_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const ServiceApp());
}

class ServiceApp extends StatelessWidget {
  const ServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Service App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.signIn,
      routes: {
        AppRoutes.signIn: (_) => const SignInScreen(),
        AppRoutes.dashboard: (_) => const DashboardScreen(),
        AppRoutes.services: (_) => const ServiceListScreen(),
        AppRoutes.serviceDetails: (_) => const ServiceDetailsScreen(),
        AppRoutes.createService: (_) => const CreateServiceScreen(),
        AppRoutes.updateService: (_) => const UpdateServiceScreen(),
      },
    );
  }
}
