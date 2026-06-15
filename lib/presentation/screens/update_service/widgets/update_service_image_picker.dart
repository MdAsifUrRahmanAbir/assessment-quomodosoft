import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../bloc/service/service_cubit.dart';
import '../../../widgets/service_form_widgets.dart';

class UpdateServiceImagePicker extends StatefulWidget {
  const UpdateServiceImagePicker({
    super.key,
    required this.isLoading,
  });

  final bool isLoading;

  @override
  State<UpdateServiceImagePicker> createState() => _UpdateServiceImagePickerState();
}

class _UpdateServiceImagePickerState extends State<UpdateServiceImagePicker> {
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        context.read<ServiceCubit>().selectedImagePathForUpdate = picked.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ServiceCubit>();

    return ImageUploadBox(
      onTap: widget.isLoading ? null : _pickImage,
      imagePath: cubit.selectedImagePathForUpdate,
    );
  }
}
