import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/profile/bloc.dart';
import 'package:flutter_bloc_example/profile/models/events.dart';
import 'package:flutter_bloc_example/profile/extensions.dart';

class EditProfileNameField extends StatefulWidget {
  const EditProfileNameField({super.key});

  @override
  EditProfileNameFieldState createState() => EditProfileNameFieldState();
}

class EditProfileNameFieldState extends State<EditProfileNameField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (_controller.text != context.profile.name) {
      _controller.text = context.profile.name;
    }
    return TextField(
      controller: _controller,
      enabled: !context.profile.isLoading,
      onChanged: (value) => context.read<ProfileService>().add(
            NameChangedProfileEvent(name: value)),
      decoration: const InputDecoration(labelText: 'Name'),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
