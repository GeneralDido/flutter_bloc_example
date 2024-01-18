import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/core/core.dart';
import 'package:flutter_bloc_example/profile/models/errors.dart';
import 'package:flutter_bloc_example/profile/models/events.dart';
import 'package:flutter_bloc_example/profile/models/profile.dart';
import 'package:fpdart/fpdart.dart' hide State;

Future<Profile> profileLoader() async {
  // Simulate an asynchronous operation by delaying for a short duration
  await Future.delayed(const Duration(milliseconds: 100));
  // Return an empty profile
  return const Profile(name: '', age: 0);
}

class ProfileService extends Bloc<ProfileEvent, State<Profile, ProfileErrorType>> {
  ProfileService()
      : super(const InitState()) { // Initialize with InitState
    on<NameChangedProfileEvent>(_onNameChanged);
    on<AgeChangedProfileEvent>(_onAgeChanged);
    on<SaveProfileEvent>(_onSaveProfile);
    on<ClearProfileEvent>(_onClearProfile);
    on<LoadProfileEvent>(_onLoadProfile);
  }

  void _onNameChanged(
    NameChangedProfileEvent event,
    Emitter<State<Profile, ProfileErrorType>> emit,
  ) {
      switch(state) {
        case InitState<Profile, ProfileErrorType>(): 
          return;
        case DataState<Profile, ProfileErrorType>(
          value: final profile,
        ):
          return emit(DataState(
            value: profile.copyWith(name: event.name),
          ));
        case ErrorState<Profile, ProfileErrorType>(
          value: final option,
          error: final error,
        ): return option.match(
          () => {
            // no name
          },
          (profile) => emit(ErrorState(
            value: Option.of(profile.copyWith(name: event.name)),
            error: error,
          )
        ));
        case LoadingState<Profile, ProfileErrorType>(
          value: final option,
        ): return option.match(
          () => {
            // no name
          },
          (profile) => emit(LoadingState(
            value: Option.of(profile.copyWith(name: event.name)),
          )
        ));
      }
  }

  void _onAgeChanged(
    AgeChangedProfileEvent event,
    Emitter<State<Profile, ProfileErrorType>> emit,
  ) {
    switch(state) {
      case InitState<Profile, ProfileErrorType>(): 
        return;
      case DataState<Profile, ProfileErrorType>(
        value: final profile,
      ):
        return emit(DataState(
          value: profile.copyWith(age: event.age),
        ));
      case ErrorState<Profile, ProfileErrorType>(
        value: final option,
        error: final error,
      ): return option.match(
        () => {
          // no age
        },
        (profile) => emit(ErrorState(
          value: Option.of(profile.copyWith(age: event.age)),
          error: error,
        )
      ));
      case LoadingState<Profile, ProfileErrorType>(
        value: final option,
      ): return option.match(
        () => {
          // no age
        },
        (profile) => emit(LoadingState(
          value: Option.of(profile.copyWith(age: event.age)),
        )
      ));
    }
  }

  void _onSaveProfile(
    SaveProfileEvent event,
    Emitter<State<Profile, ProfileErrorType>> emit,
  ) async {
    switch (state) {
      case InitState<Profile, ProfileErrorType>():
        return;
      case DataState<Profile, ProfileErrorType>(
        value: final profile,
      ):
        emit(LoadingState(value: Option.of(profile)));
        try {
          await Future.delayed(Duration(seconds: Random().nextInt(2) + 1));
          // Simulate successful save
          emit(DataState(value: profile)); // Keep the same profile in the DataState
        } catch (error, trace) {
          emit(ErrorState(
            value: Option.of(profile),
            error: UnknownProfileErrorType(
              error: error,
              trace: trace,
            ),
          ));
        }
        break;
      case ErrorState<Profile, ProfileErrorType>(
        value: final option,
      ):
        option.match(
          () {
            // no data
          },
          (profile) async {
            emit(LoadingState(value: Option.of(profile)));
            try {
              await Future.delayed(Duration(seconds: Random().nextInt(2) + 1));
              // Simulate successful save
              return emit(DataState(value: profile)); // Keep the same profile in the DataState
            } catch (error, trace) {
              return emit(ErrorState(
                value: Option.of(profile),
                error: UnknownProfileErrorType(
                  error: error,
                  trace: trace,
                ),
              ));
            }
          },
        );
      case LoadingState<Profile, ProfileErrorType>():
        // Already in a loading state, do nothing
        return;
    }
  }

  void _onClearProfile(
    ClearProfileEvent event,
    Emitter<State<Profile, ProfileErrorType>> emit,
  ) {
    switch(state) {
      case InitState<Profile, ProfileErrorType>(): 
        return;
      case DataState<Profile, ProfileErrorType>():
        return emit(const DataState(
          value: Profile(name: '', age: 0),
      ));
      case ErrorState<Profile, ProfileErrorType>(
        value: final option,
        error: final error,
      ): return option.match(
        () => {
          // no data
        },
        (profile) => emit(ErrorState(
          value: const Option.of(Profile(name: '', age: 0)),
          error: error,
        )
      ));
      case LoadingState<Profile, ProfileErrorType>(
        value: final option,
      ): return option.match(
        () => {
          // no data
        },
        (profile) => emit(const LoadingState(
          value: Option.of(Profile(name: '', age: 0)),
        )
      ));
    }
  }
  
  /// Loads profile using [loader] and updates state
  Future<void> _onLoadProfile(LoadProfileEvent event,
    Emitter<State<Profile, ProfileErrorType>> emit,
  ) async {
    emit(const LoadingState());
    try {
      emit(DataState(value: await profileLoader()));
    }
    catch (error, trace) {
      emit(ErrorState(error: UnknownProfileErrorType(
        error: error,
        trace: trace,
      )));
    }
  }
}

