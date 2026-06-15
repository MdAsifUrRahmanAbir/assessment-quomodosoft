import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/di/injection_container.dart';
import '../../bloc/service/service_cubit.dart';
import 'widgets/service_list_app_bar.dart';
import 'widgets/service_list_view.dart';

/// Screen 03 – Services Listing (Stateless)
class ServiceListScreen extends StatelessWidget {
  const ServiceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceCubit>(
      create: (_) => sl<ServiceCubit>()..loadServices(),
      child: const Scaffold(
        backgroundColor: AppColors.scaffold,
        extendBody: true,
        appBar: ServiceListAppBar(),
        body: SafeArea(
          bottom: false,
          child: ServiceListView(),
        ),
      ),
    );
  }
}
