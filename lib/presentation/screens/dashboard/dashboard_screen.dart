import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'widgets/dashboard_header.dart';
import 'widgets/dashboard_stats_grid.dart';
import 'widgets/dashboard_transactions.dart';

/// Screen 02 – Dashboard (Home - Stateless)
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.scaffold,
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            DashboardHeader(),
            DashboardStatsGrid(),
            DashboardTransactions(),
            SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}
