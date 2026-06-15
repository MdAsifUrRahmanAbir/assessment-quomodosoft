import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/api_endpoint.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../data/models/user_model.dart';

class DashboardAvatar extends StatelessWidget {
  const DashboardAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    String? avatarUrl;
    final userJson = LocalStorage.getUserJson();
    if (userJson != null) {
      try {
        final user = UserModel.fromJson(json.decode(userJson) as Map<String, dynamic>);
        if (user.avatarUrl.isNotEmpty) {
          avatarUrl = user.avatarUrl;
        }
      } catch (_) {}
    }

    final bool isPlaceholder = ApiEndpoint.mainDomain.contains('example.com');
    final String fullUrl;
    if (avatarUrl == null || avatarUrl.isEmpty || isPlaceholder) {
      fullUrl = "https://i.pravatar.cc/150?img=33";
    } else {
      fullUrl = avatarUrl.startsWith('http')
          ? avatarUrl
          : "${ApiEndpoint.mainDomain}/$avatarUrl";
    }

    return ClipOval(
      child: Image.network(
        fullUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(Icons.person, color: AppColors.textWhite, size: 20),
      ),
    );
  }
}
