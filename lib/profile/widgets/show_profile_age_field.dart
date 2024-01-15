import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/profile/extensions.dart';

class ShowProfileAgeField extends StatelessWidget {
  const ShowProfileAgeField({super.key});

  @override
  Widget build(BuildContext context) => Text("${context.profile.age}");
}