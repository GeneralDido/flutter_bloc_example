import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/profile/bloc.dart';
import 'package:flutter_bloc_example/profile/events.dart';
import 'package:flutter_bloc_example/profile/models/profile_state.dart';

class EditProfileAgeField extends StatefulWidget {
  const EditProfileAgeField({super.key});

  @override
  EditProfileAgeFieldState createState() => EditProfileAgeFieldState();
}

class EditProfileAgeFieldState extends State<EditProfileAgeField> {
  late final _controller = TextEditingController(
    text: "${context.read<ProfileService>().state.profile.age}",
  );

  int _parseValueToAge(String value) => int.tryParse(value) ?? 0;

  @override
  Widget build(BuildContext context) =>
      BlocListener<ProfileService, ProfileState>(
        listener: (context, state) {
          if ("${state.profile.age}" != _controller.text) {
            _controller.text = "${state.profile.age}";
          }
        },
        child: BlocBuilder<ProfileService, ProfileState>(
          builder: (context, state) => TextField(
            controller: _controller,
            enabled: !state.isLoading,
            onChanged: (value) =>
                context.read<ProfileService>().add(AgeChangedProfileEvent(
                      age: _parseValueToAge(value),
                    )),
            decoration: const InputDecoration(labelText: 'Age'),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ),
      );
}