import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/service/service_cubit.dart';
import '../../../widgets/service_form_widgets.dart';

class UpdateServiceFeatureList extends StatefulWidget {
  const UpdateServiceFeatureList({super.key});

  @override
  State<UpdateServiceFeatureList> createState() => _UpdateServiceFeatureListState();
}

class _UpdateServiceFeatureListState extends State<UpdateServiceFeatureList> {
  void _addFeature() {
    setState(() {
      context.read<ServiceCubit>().updateFeatureCtrs.add(TextEditingController());
    });
  }

  void _removeFeature(int index) {
    setState(() {
      final cubit = context.read<ServiceCubit>();
      cubit.updateFeatureCtrs[index].dispose();
      cubit.updateFeatureCtrs.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ServiceCubit>();

    return PackageFeaturesSection(
      controllers: cubit.updateFeatureCtrs,
      onAdd: _addFeature,
      onRemove: _removeFeature,
    );
  }
}
