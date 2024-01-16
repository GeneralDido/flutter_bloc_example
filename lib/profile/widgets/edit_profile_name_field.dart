import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/profile/bloc.dart';
import 'package:flutter_bloc_example/profile/models/events.dart';
import 'package:flutter_bloc_example/profile/models/errors.dart';
import 'package:flutter_bloc_example/core/core.dart' as core;
import 'package:flutter_bloc_example/profile/models/profile.dart';

class EditProfileNameField extends StatefulWidget {
  const EditProfileNameField({super.key});

  @override
  EditProfileNameFieldState createState() => EditProfileNameFieldState();
}

class EditProfileNameFieldState extends State<EditProfileNameField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileService, core.State<Profile, ProfileErrorType>>(
      listener: (context, state) {
        if (state is core.DataState<Profile, ProfileErrorType>) {
          _controller.text = state.value.name;
        } else if (state is core.InitState) {
          _controller.text = ""; // Reset text on InitState
        }
      },
      child: BlocBuilder<ProfileService, core.State<Profile, ProfileErrorType>>(
        builder: (context, state) {
          final isStateLoading = state is core.LoadingState<Profile, ProfileErrorType>;
          return TextField(
            controller: _controller,
            enabled: !isStateLoading,
            onChanged: (value) => context
                .read<ProfileService>()
                .add(NameChangedProfileEvent(name: value)),
            decoration: const InputDecoration(labelText: 'Name'),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
