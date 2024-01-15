import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/profile/bloc.dart';
import 'package:flutter_bloc_example/profile/models/profile_state.dart';

extension ProfileServiceBuildContextExtension on BuildContext {
  ProfileServiceSelector get profile => ProfileServiceSelector(this);
}

class ProfileServiceSelector {
  @protected
  final BuildContext context;

  const ProfileServiceSelector(this.context);

  @protected
  D getData<D>(D Function(ProfileState) selector) =>
      context.select<ProfileService, D>((bloc) => selector(bloc.state));

  String get name => getData((state) => state.profile.name);

  num get age => getData((state) => state.profile.age);

  bool get isLoading => getData((state) => state.isLoading);
}