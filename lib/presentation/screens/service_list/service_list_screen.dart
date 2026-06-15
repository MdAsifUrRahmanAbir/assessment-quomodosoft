import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/injection_container.dart';
import '../../../core/routes/app_routes.dart';
import '../../bloc/service/service_cubit.dart';
import '../../widgets/app_bottom_nav_bar.dart';
import 'widgets/service_list_app_bar.dart';
import 'widgets/service_list_view.dart';

/// Screen 03 – Services Listing (Stateless)
class ServiceListScreen extends StatelessWidget {
  const ServiceListScreen({super.key});

  void _onNavTap(BuildContext context, int index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceCubit>(
      create: (_) => sl<ServiceCubit>()..loadServices(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F7F7),
        extendBody: true,
        appBar: const ServiceListAppBar(),
        body: const SafeArea(
          bottom: false,
          child: ServiceListView(),
        ),
        bottomNavigationBar: AppBottomNavBar(
          currentIndex: 1,
          onTap: (index) => _onNavTap(context, index),
        ),
      ),
    );
  }
}
