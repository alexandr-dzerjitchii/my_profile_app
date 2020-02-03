import 'package:endava_profile_app/modules/common/components/button.dart';
import 'package:endava_profile_app/modules/common/components/text_input.dart';
import 'package:endava_profile_app/modules/login/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  LoginBloc _loginBloc;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state.isFormSubmitted) {
          print('Form submitted');
        }
        return Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  TextInput(
                    hintText: 'Email address',
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    autovalidate: true,
                    validator: (_) =>
                        state.isEmailValid ? null : 'Invalid email',
                  ),
                  SizedBox(height: 20.0),
                  TextInput(
                    hintText: 'Password',
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    autovalidate: true,
                    validator: (_) =>
                        state.isPasswordValid ? null : 'Invalid password',
                  ),
                ],
              ),
              FractionallySizedBox(
                widthFactor: 0.6,
                child: Button(
                  label: 'Continue',
                  onPressed: _onContinuePressed,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(EmailChanged());
  }

  void _onPasswordChanged() {
    _loginBloc.add(PasswordChanged());
  }

  void _onContinuePressed() {
    _loginBloc.add(
      FormSubmitted(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}