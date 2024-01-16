import 'package:flutter/material.dart' hide State;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/profile/bloc.dart';
import 'package:flutter_bloc_example/profile/models/errors.dart';
import 'package:flutter_bloc_example/profile/models/events.dart';
import 'package:flutter_bloc_example/core/core.dart';
import 'package:flutter_bloc_example/profile/models/profile.dart';

class SaveProfileButton extends StatelessWidget {
  const SaveProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileService, State<Profile, ProfileErrorType>>(
      builder: (context, state) {
        final isStateLoading = state is LoadingState<Profile, ProfileErrorType>;

        return ElevatedButton(
          onPressed: isStateLoading
              ? null
              : () => context.read<ProfileService>().add(const SaveProfileEvent()),
          child: const Text('Save'),
        );
      },
    );
  }
}
