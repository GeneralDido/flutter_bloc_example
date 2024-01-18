import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/profile/widgets/clear_profile_button.dart';
import 'package:flutter_bloc_example/profile/widgets/edit_profile_age_field.dart';
import 'package:flutter_bloc_example/profile/widgets/edit_profile_name_field.dart';
import 'package:flutter_bloc_example/profile/widgets/load_profile_button.dart';
import 'package:flutter_bloc_example/profile/widgets/save_profile_button.dart';
import 'package:flutter_bloc_example/profile/widgets/show_profile_age_field.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) => const Column(
        children: [
          EditProfileNameField(),
          EditProfileAgeField(),
          ShowProfileAgeField(),
          Row(
            children: [
              Expanded(
                child: SaveProfileButton(),
              ),
              ClearProfileButton(),
              LoadProfileButton(),
            ],
          ),
        ],
      );
}