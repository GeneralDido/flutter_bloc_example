import 'package:flutter_bloc_example/profile/models/profile.dart';

class ProfileState {
  final Profile profile;
  final bool isLoading;

  const ProfileState({
    required this.profile,
    required this.isLoading,
  });
}