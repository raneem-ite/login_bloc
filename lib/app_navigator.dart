// app Navigator will show either app flow or authentication flow
import 'package:authentication_system_with_bloc/Auth/auth_cubit.dart';
import 'package:authentication_system_with_bloc/Auth/auth_navigator.dart';
import 'package:authentication_system_with_bloc/loading_view.dart';
import 'package:authentication_system_with_bloc/session_cubit.dart';
import 'package:authentication_system_with_bloc/session_state.dart';
import 'package:authentication_system_with_bloc/session_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            // show loading screen
            if (state is UnkownSessionState)
              const MaterialPage(child: LoadingView()),

            // show auth flow
            if (state is Unauthenticated)
              MaterialPage(
                child: BlocProvider(
                  create: (context) =>
                      AuthCubit(sessionCubit: context.read<SessionCubit>()),
                  child: const AuthNavigator(),
                ),
              ),
            //show session flow
            if (state is Authenticated) const MaterialPage(child: SessionView())
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
