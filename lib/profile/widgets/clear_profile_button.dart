import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/profile/bloc.dart';
import 'package:flutter_bloc_example/profile/events.dart';
import 'package:flutter_bloc_example/profile/models/profile_state.dart';

class ClearProfileButton extends StatelessWidget {
  const ClearProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileService, ProfileState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.isLoading
              ? null
              : () =>
                  context.read<ProfileService>().add(const ClearProfileEvent()),
          child: const Text('Clear'),
        );
      },
    );
  }
}