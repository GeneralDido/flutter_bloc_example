import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/profile/bloc.dart'; // Import the necessary package

class ProfileServiceProvider extends StatelessWidget {
  final Widget child;

  const ProfileServiceProvider({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => BlocProvider( // Define the missing method 'BlocProvider'
    create: (context) => ProfileService(),
    child: child,
  );
}