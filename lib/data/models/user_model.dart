import '../../domain/entities/user_entity.dart';

/// JSON-serializable Data Transfer Object (DTO) for an authenticated User.
class UserModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
    this.avatarUrl = '',
  });

  final String id;
  final String name;
  final String email;
  final String token;
  final String avatarUrl;

  // ── fromJson ──────────────────────────────────────────────────────────────
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] ?? json['user']?['id'] ?? '').toString(),
      name: json['name'] as String? ??
          json['user']?['name'] as String? ??
          '',
      email: json['email'] as String? ??
          json['user']?['email'] as String? ??
          '',
      token: json['token'] as String? ??
          json['access_token'] as String? ??
          '',
      avatarUrl: json['avatar_url'] as String? ??
          json['user']?['avatar_url'] as String? ??
          json['user']?['image'] as String? ??
          '',
    );
  }

  // ── toJson ────────────────────────────────────────────────────────────────
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'token': token,
      'avatar_url': avatarUrl,
    };
  }

  // ── toEntity ──────────────────────────────────────────────────────────────
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      token: token,
      avatarUrl: avatarUrl,
    );
  }

  // ── fromEntity ────────────────────────────────────────────────────────────
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      token: entity.token,
      avatarUrl: entity.avatarUrl,
    );
  }
}
