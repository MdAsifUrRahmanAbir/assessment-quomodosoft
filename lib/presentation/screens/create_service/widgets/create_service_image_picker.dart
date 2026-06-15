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
  bool _isPicking = false;

  Future<void> _pickImage() async {
    if (_isPicking) return;
    setState(() => _isPicking = true);

    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(source: ImageSource.gallery);
      if (picked != null && mounted) {
        setState(() {
          context.read<ServiceCubit>().selectedImagePathForCreate = picked.path;
        });
      }
    } catch (_) {
      // Safe guard against platform picker issues
    } finally {
      if (mounted) {
        setState(() => _isPicking = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ServiceCubit>();

    return ImageUploadBox(
      onTap: (widget.isLoading || _isPicking) ? null : _pickImage,
      imagePath: cubit.selectedImagePathForCreate,
    );
  }
}
