import 'package:authentication_system_with_bloc/Auth/auth_repository.dart';
import 'package:authentication_system_with_bloc/app_navigator.dart';
import 'package:authentication_system_with_bloc/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RepositoryProvider(
        create: (context) => AuthRepository(),
        child: BlocProvider(
          create: (context) =>
              SessionCubit(authRepo: context.read<AuthRepository>()),
          child: const AppNavigator(),
        ),
      ),
    );
  }
}
