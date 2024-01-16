import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/profile/bloc.dart';
import 'package:flutter_bloc_example/profile/models/errors.dart';
import 'package:flutter_bloc_example/profile/models/events.dart';
import 'package:flutter_bloc_example/core/core.dart' as core;
import 'package:flutter_bloc_example/profile/models/profile.dart';

class EditProfileAgeField extends StatefulWidget {
  const EditProfileAgeField({super.key});

  @override
  EditProfileAgeFieldState createState() => EditProfileAgeFieldState();
}

class EditProfileAgeFieldState extends State<EditProfileAgeField> {
  final TextEditingController _controller = TextEditingController();

  int _parseValueToAge(String value) => int.tryParse(value) ?? 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileService, core.State<Profile, ProfileErrorType>>(
      listener: (context, state) {
        if (state is core.DataState<Profile, ProfileErrorType>) {
          _controller.text = state.value.age.toString();
        } else if (state is core.InitState) {
          _controller.text = "0"; // Reset text on InitState
        }
      },
      child: BlocBuilder<ProfileService, core.State<Profile, ProfileErrorType>>(
        builder: (context, state) {
          final isStateLoading = state is core.LoadingState<Profile, ProfileErrorType>;
          return TextField(
            controller: _controller,
            enabled: !isStateLoading,
            onChanged: (value) => context.read<ProfileService>().add(
                  AgeChangedProfileEvent(age: _parseValueToAge(value)),
                ),
            decoration: const InputDecoration(labelText: 'Age'),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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