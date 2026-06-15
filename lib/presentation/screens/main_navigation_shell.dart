import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/injection_container.dart';
import '../bloc/navigation/navigation_cubit.dart';
import '../widgets/app_bottom_nav_bar.dart';
import 'dashboard/dashboard_screen.dart';
import 'service_list/service_list_screen.dart';

class MainNavigationShell extends StatelessWidget {
  const MainNavigationShell({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationCubit>(
      create: (_) => sl<NavigationCubit>(),
      child: const _MainNavigationShellView(),
    );
  }
}

class _MainNavigationShellView extends StatelessWidget {
  const _MainNavigationShellView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          extendBody: true,
          body: IndexedStack(
            index: currentIndex,
            children: const [
              DashboardScreen(),
              ServiceListScreen(),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: AppBottomNavBar(
              currentIndex: currentIndex,
              onTap: (index) => context.read<NavigationCubit>().setTab(index),
            ),
          ),
        );
      },
    );
  }
}
