import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/profile/provider.dart';
import 'package:flutter_bloc_example/profile/widgets/profile_form.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: ProfileServiceProvider(
                  child: ProfileForm())
              ),
            ],
          ),
        ),
      ),
    );
  }
}
