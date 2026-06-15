import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/service/service_cubit.dart';
import '../../../widgets/service_form_widgets.dart';

class CreateServiceFeatureList extends StatefulWidget {
  const CreateServiceFeatureList({super.key});

  @override
  State<CreateServiceFeatureList> createState() => _CreateServiceFeatureListState();
}

class _CreateServiceFeatureListState extends State<CreateServiceFeatureList> {
  void _addFeature() {
    setState(() {
      context.read<ServiceCubit>().createFeatureCtrs.add(TextEditingController());
    });
  }

  void _removeFeature(int index) {
    setState(() {
      final cubit = context.read<ServiceCubit>();
      cubit.createFeatureCtrs[index].dispose();
      cubit.createFeatureCtrs.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ServiceCubit>();

    return PackageFeaturesSection(
      controllers: cubit.createFeatureCtrs,
      onAdd: _addFeature,
      onRemove: _removeFeature,
    );
  }
}
