import 'package:authentication_system_with_bloc/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionView extends StatelessWidget {
  const SessionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("session view"),
            TextButton(
              onPressed: () => context.read<SessionCubit>().signOut(),
              child: const Text('sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
