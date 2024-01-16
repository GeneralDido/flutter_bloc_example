import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/core/core.dart';
import 'package:flutter_bloc_example/profile/models/errors.dart';
import 'package:flutter_bloc_example/profile/models/events.dart';
import 'package:flutter_bloc_example/profile/models/profile.dart';
import 'package:fpdart/fpdart.dart' hide State;

class ProfileService extends Bloc<ProfileEvent, State<Profile, ProfileErrorType>> {
  ProfileService()
      : super(const InitState()) { // Initialize with InitState
    on<NameChangedProfileEvent>(_onNameChanged);
    on<AgeChangedProfileEvent>(_onAgeChanged);
    on<SaveProfileEvent>(_onSaveProfile);
    on<ClearProfileEvent>(_onClearProfile);
  }

  void _onNameChanged(
    NameChangedProfileEvent event,
    Emitter<State<Profile, ProfileErrorType>> emit,
  ) {
    final currentProfile = _getCurrentProfile();
    emit(DataState(value: currentProfile.copyWith(name: event.name)));
  }

  void _onAgeChanged(
    AgeChangedProfileEvent event,
    Emitter<State<Profile, ProfileErrorType>> emit,
  ) {
    final currentProfile = _getCurrentProfile();
    emit(DataState(value: currentProfile.copyWith(age: event.age)));
  }

  void _onSaveProfile(
    SaveProfileEvent event,
    Emitter<State<Profile, ProfileErrorType>> emit,
  ) async {
    final currentProfile = _getCurrentProfile();
    emit(LoadingState(value: Option.of(currentProfile)));

    try {
      await Future.delayed(Duration(seconds: Random().nextInt(2) + 1));
      // Re-emit the current profile to signify the completion of the save operation
      emit(DataState(value: currentProfile));
    } catch (error, stacktrace) {
      // In case of an error, emit an ErrorState
      emit(ErrorState(
        value: Option.of(currentProfile),
        error: ProfileErrorType(
          error: error,
          trace: stacktrace,
        ),
      ));
    }
  }

  void _onClearProfile(
    ClearProfileEvent event,
    Emitter<State<Profile, ProfileErrorType>> emit,
  ) {
    emit(const InitState()); // Reset to initial state with default profile
  }

  Profile _getCurrentProfile() {
  // Retrieve the current profile or return a default profile if not available
    return state is DataState<Profile, ProfileErrorType> ? 
    (state as DataState<Profile, ProfileErrorType>).value : 
    const Profile(name: '', age: 0);
  }
}

