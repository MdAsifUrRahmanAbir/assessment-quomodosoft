import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';
import '../../widgets/app_bottom_nav_bar.dart';
import 'widgets/dashboard_header.dart';
import 'widgets/dashboard_stats_grid.dart';
import 'widgets/dashboard_transactions.dart';

/// Screen 02 – Dashboard (Home - Stateless)
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  void _onNavTap(BuildContext context, int index) {
    if (index == 1) {
      Navigator.pushReplacementNamed(context, AppRoutes.services);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: const SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              DashboardHeader(),
              DashboardStatsGrid(),
              DashboardTransactions(),
              SizedBox(height: 120),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 0,
        onTap: (index) => _onNavTap(context, index),
      ),
    );
  }
}
