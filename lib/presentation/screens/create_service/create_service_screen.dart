import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/di/injection_container.dart';
import '../../../core/services/app_snackbar.dart';
import '../../bloc/service/service_cubit.dart';
import 'widgets/create_service_form.dart';

/// Screen 04 – Add New Service (Create - BLoC-driven, Stateless)
class CreateServiceScreen extends StatelessWidget {
  const CreateServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceCubit>(
      create: (_) => sl<ServiceCubit>(),
      child: const _CreateServiceView(),
    );
  }
}

class _CreateServiceView extends StatelessWidget {
  const _CreateServiceView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceCubit, ServiceState>(
      listener: (context, state) {
        if (state is ServiceOperationSuccess) {
          AppSnackBar.success(state.message);
          Navigator.pop(context);
        } else if (state is ServiceError) {
          AppSnackBar.error(state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is ServiceLoading;

        return Scaffold(
          backgroundColor: AppColors.scaffold,
          appBar: AppBar(
            backgroundColor: AppColors.scaffold,
            elevation: 0,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.only(left: AppSizes.paddingM),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.inputBg,
                    borderRadius: BorderRadius.circular(AppSizes.radiusS),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: AppColors.textDark, size: AppSizes.iconS),
                ),
              ),
            ),
            title: Text(
              'Add New Services',
              style: GoogleFonts.poppins(
                color: AppColors.textDark,
                fontSize: AppSizes.fontL,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
              child: CreateServiceForm(isLoading: isLoading),
            ),
          ),
        );
      },
    );
  }
}
