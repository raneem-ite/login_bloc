import 'package:authentication_system_with_bloc/Auth/auth_cubit.dart';
import 'package:authentication_system_with_bloc/Auth/auth_repository.dart';
import 'package:authentication_system_with_bloc/Auth/form_submission_status.dart';
import 'package:authentication_system_with_bloc/Auth/login/login_bloc.dart';
import 'package:authentication_system_with_bloc/Auth/login/login_event.dart';
import 'package:authentication_system_with_bloc/Auth/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(
            authRepo: context.read<AuthRepository>(),
            authCubit: context.read<AuthCubit>()),
        child: Stack(alignment: Alignment.bottomCenter, children: [
          _loginForm(),
          _showSignupButton(context),
        ]),
      ),
    );
  }

  Widget _loginForm() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackbar(context, formStatus.exception.toString());
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _usernameField(),
              _passwordField(),
              _loginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _usernameField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          decoration: const InputDecoration(
              icon: Icon(Icons.person), hintText: "Username"),
          validator: (value) =>
              state.isValidUser ? null : "username is too short",
          onChanged: (value) => context
              .read<LoginBloc>()
              .add(LoginUsernameChanged(username: value)),
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
              icon: Icon(Icons.security), hintText: "Password"),
          validator: (value) =>
              state.isValidPassword ? null : "the Password is too short",
          onChanged: (value) => context
              .read<LoginBloc>()
              .add(LoginPasswordChanged(password: value)),
        );
      },
    );
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(LoginSubmitted());
                    // if (state.formStatus is SubmissionSuccess) print("dhs");
                  }
                },
                child: const Text("login"),
              );
      },
    );
  }

  Widget _showSignupButton(BuildContext context) {
    return SafeArea(
        child: TextButton(
      child: const Text("Don't have an account? Sign up"),
      onPressed: () => context.read<AuthCubit>().showSignUp(),
    ));
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
