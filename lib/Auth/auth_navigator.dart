import 'package:authentication_system_with_bloc/Auth/auth_cubit.dart';
import 'package:authentication_system_with_bloc/Auth/confirmation/confirmation_view.dart';
import 'package:authentication_system_with_bloc/Auth/signup/sign_up_view.dart';
import 'package:authentication_system_with_bloc/Auth/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthNavigator extends StatelessWidget {
  const AuthNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            // show login
            if (state == AuthState.login) MaterialPage(child: LoginView()),

            // allow push animation
            if (state == AuthState.signUp ||
                state == AuthState.confirmSignUp) ...[
              // show sign up page
              MaterialPage(child: SignUpView()),

              //show confirm sign up
              if (state == AuthState.confirmSignUp)
                MaterialPage(child: ConfirmationView())
            ]
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
