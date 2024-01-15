import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/profile/bloc.dart';
import 'package:flutter_bloc_example/profile/events.dart';
import 'package:flutter_bloc_example/profile/extensions.dart';
import 'package:flutter_bloc_example/profile/models/profile_state.dart';

class EditProfileNameField extends StatefulWidget {
  const EditProfileNameField({super.key});

  @override
  EditProfileNameFieldState createState() => EditProfileNameFieldState();
}

class EditProfileNameFieldState extends State<EditProfileNameField> {
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) =>
      BlocListener<ProfileService, ProfileState>(
        listener: (context, state) {
          if (state.profile.name != nameController.text) {
            nameController.text = state.profile.name;
          }
        },
        child: Builder(
          builder: (context) {
            final isLoading = context.profile.isLoading;
            return TextField(
              controller: nameController,
              enabled: !isLoading,
              onChanged: (value) => context
                  .read<ProfileService>()
                  .add(NameChangedProfileEvent(name: value)),
              decoration: const InputDecoration(labelText: 'Name'),
            );
          },
        ),
      );
}

