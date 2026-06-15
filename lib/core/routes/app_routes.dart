import 'package:flutter/material.dart';
import '../../presentation/screens/sign_in/sign_in_screen.dart';
import '../../presentation/screens/service_list/service_list_screen.dart';
import '../../presentation/screens/service_details/service_details_screen.dart';
import '../../presentation/screens/create_service/create_service_screen.dart';
import '../../presentation/screens/update_service/update_service_screen.dart';
import '../../presentation/screens/main_navigation_shell.dart';

/// Centralized route name constants and route map for the app.
class AppRoutes {
  AppRoutes._();

  // ── Route name constants ──────────────────────────────────────
  static const String signIn         = '/sign-in';
  static const String dashboard      = '/dashboard';
  static const String services       = '/services';
  static const String serviceDetails = '/service-details';
  static const String createService  = '/create-service';
  static const String updateService  = '/update-service';

  // ── Route map ────────────────────────────────────────────────
  /// Used directly in [MaterialApp.routes].
  static Map<String, WidgetBuilder> get routes => {
        signIn:         (_) => const SignInScreen(),
        dashboard:      (_) => const MainNavigationShell(),
        services:       (_) => const ServiceListScreen(),
        serviceDetails: (_) => const ServiceDetailsScreen(),
        createService:  (_) => const CreateServiceScreen(),
        updateService:  (_) => const UpdateServiceScreen(),
      };
}
