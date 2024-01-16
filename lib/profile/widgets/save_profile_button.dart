import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/profile/bloc.dart';
import 'package:flutter_bloc_example/profile/extensions.dart';
import 'package:flutter_bloc_example/profile/models/events.dart';

class SaveProfileButton extends StatelessWidget {
  const SaveProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: context.profile.isLoading ? null : () => context.read<ProfileService>().add(const SaveProfileEvent()),
      child: const Text('Save'),
    );
  }
}
