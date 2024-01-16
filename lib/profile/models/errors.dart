import 'package:flutter_bloc_example/core/core.dart';
import 'package:flutter_bloc_example/profile/models/profile.dart';

/// Base profile error type, indicates [error] at [trace] with [profile]
class ProfileErrorType extends ErrorState<Profile, dynamic> {
  final Profile profile;

  const ProfileErrorType({
    required this.profile,
    required super.value,
    required super.error,
  });

  @override
  String toString() => "${super.toString()} (profile: $profile)";
}
