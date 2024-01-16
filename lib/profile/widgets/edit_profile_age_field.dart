import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/profile/bloc.dart';
import 'package:flutter_bloc_example/profile/models/events.dart';
import 'package:flutter_bloc_example/profile/extensions.dart';

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
    if (_controller.text != context.profile.age.toString()) {
      _controller.text = context.profile.age.toString();
    }

    return TextField(
      controller: _controller,
      enabled: !context.profile.isLoading,
      onChanged: (value) => context.read<ProfileService>().add(
            AgeChangedProfileEvent(age: _parseValueToAge(value)),
          ),
      decoration: const InputDecoration(labelText: 'Age'),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
