import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/profile/bloc.dart';
import 'package:flutter_bloc_example/profile/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/profile/models/events.dart';

class LoadProfileButton extends StatelessWidget {
  const LoadProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: context.profile.isLoading
          ? null
          : () => context.read<ProfileService>().add(const LoadProfileEvent()),
      child: const Icon(Icons.refresh),
    );
  }
}