import 'package:flutter/material.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_assets.dart';
import 'dashboard_stat_card.dart';
import 'dashboard_stat_model.dart';

class DashboardStatsGrid extends StatelessWidget {
  final List<DashboardStatModel> _stats = const [
    DashboardStatModel(icon: AppAssets.activeOrder, value: '12', label: 'Active Order'),
    DashboardStatModel(icon: AppAssets.pendingOrder, value: '04', label: 'Pending Order', isSvg: false),
    DashboardStatModel(icon: AppAssets.completeOrder, value: '450', label: 'Complete Order'),
    DashboardStatModel(icon: AppAssets.totalServices, value: '14', label: 'Total Services'),
    DashboardStatModel(icon: AppAssets.todayEarning, value: '\$320', label: 'Today Earning'),
    DashboardStatModel(icon: AppAssets.totalEarning, value: '\$50K', label: 'TotalEarning'),
  ];

  const DashboardStatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.paddingM),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: AppSizes.paddingM,
          crossAxisSpacing: AppSizes.paddingM,
          childAspectRatio: 2.0,
        ),
        itemCount: _stats.length,
        itemBuilder: (context, i) => DashboardStatCard(item: _stats[i]),
      ),
    );
  }
}
