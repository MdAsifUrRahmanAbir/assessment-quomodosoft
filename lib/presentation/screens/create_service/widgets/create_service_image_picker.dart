import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../bloc/service/service_cubit.dart';
import '../../../widgets/service_form_widgets.dart';

class CreateServiceImagePicker extends StatefulWidget {
  const CreateServiceImagePicker({
    super.key,
    required this.isLoading,
  });

  final bool isLoading;

  @override
  State<CreateServiceImagePicker> createState() => _CreateServiceImagePickerState();
}

class _CreateServiceImagePickerState extends State<CreateServiceImagePicker> {
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        context.read<ServiceCubit>().selectedImagePathForCreate = picked.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ServiceCubit>();

    return ImageUploadBox(
      onTap: widget.isLoading ? null : _pickImage,
      imagePath: cubit.selectedImagePathForCreate,
    );
  }
}
