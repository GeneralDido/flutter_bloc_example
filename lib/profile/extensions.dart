import 'package:flutter/material.dart' hide State;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/profile/bloc.dart';
import 'package:flutter_bloc_example/profile/models/errors.dart';
import 'package:flutter_bloc_example/profile/models/profile.dart';
import 'package:flutter_bloc_example/core/core.dart';


extension ProfileServiceBuildContextExtension on BuildContext {
  ProfileServiceSelector get profile => ProfileServiceSelector(this);
}

class ProfileServiceSelector {
  @protected
  final BuildContext context;

  const ProfileServiceSelector(this.context);

  @protected
  D getData<D>(D Function(State<Profile, ProfileErrorType>) selector) =>
      context.select<ProfileService, D>((bloc) => selector(bloc.state));

  String get name => getData((state) {
        switch (state) {
          case InitState<Profile, ProfileErrorType>():
            return "";

          case DataState<Profile, ProfileErrorType>():
            return state.value.name;

          case ErrorState<Profile, ProfileErrorType>():
            return state.value.match(
              () => "",
              (profile) => profile.name,
            );

          case LoadingState<Profile, ProfileErrorType>():
            return state.value.match(
              () => "",
              (profile) => profile.name,
            );
        }
      });

  int get age => getData((state) {
        switch (state) {
          case InitState<Profile, ProfileErrorType>():
            return 0;

          case DataState<Profile, ProfileErrorType>():
            return state.value.age;

          case ErrorState<Profile, ProfileErrorType>():
            return state.value.match(
              () => 0,
              (profile) => profile.age,
            );

          case LoadingState<Profile, ProfileErrorType>():
            return state.value.match(
              () => 0,
              (profile) => profile.age,
            );
        }
      });

  bool get isLoading => getData((state) => state is LoadingState<Profile, ProfileErrorType>);
}
