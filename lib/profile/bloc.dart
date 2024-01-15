import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/profile/events.dart';
import 'package:flutter_bloc_example/profile/models/profile.dart';
import 'package:flutter_bloc_example/profile/models/profile_state.dart';


class ProfileService extends Bloc<ProfileEvent, ProfileState> {
  ProfileService()
      : super(const ProfileState(
          profile: Profile(
            name: '',
            age: 0,
          ),
          isLoading: false,
        )) {
    on<NameChangedProfileEvent>(_onNameChanged);
    on<AgeChangedProfileEvent>(_onAgeChanged);
    on<SaveProfileEvent>(_onSaveProfile);
    on<ClearProfileEvent>(_onClearProfile);
  }

  void _onNameChanged(
    NameChangedProfileEvent event,
    Emitter<ProfileState> emit,
  ) =>
      emit(ProfileState(
        profile: Profile(name: event.name, age: state.profile.age),
        isLoading: false,
      ));

  void _onAgeChanged(
    AgeChangedProfileEvent event,
    Emitter<ProfileState> emit,
  ) =>
      emit(ProfileState(
        profile: Profile(name: state.profile.name, age: event.age),
        isLoading: false,
      ));

  void _onSaveProfile(
    SaveProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileState(profile: state.profile, isLoading: true));
    await Future.delayed(Duration(seconds: Random().nextInt(2) + 1));
    emit(ProfileState(profile: state.profile, isLoading: false));
  }

  void _onClearProfile(
    ClearProfileEvent event,
    Emitter<ProfileState> emit,
  ) =>
      emit(const ProfileState(
        profile: Profile(name: '', age: 0),
        isLoading: false,
      ));
}
