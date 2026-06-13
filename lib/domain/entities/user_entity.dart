import 'package:equatable/equatable.dart';

/// Pure business object for an authenticated User.
///
/// No JSON annotations, no Flutter dependencies.
/// Maps from [UserModel] in the data layer.
class UserEntity extends Equatable {
  const UserEntity({
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

  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? token,
    String? avatarUrl,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  @override
  List<Object?> get props => [id, name, email, token, avatarUrl];
}
