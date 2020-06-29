import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:notably/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:notably/blocs/login_bloc/bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    // final _shadowBox = BlocProvider.of<ThemeBloc>(context).state.shadows;
    final _shadowBox = [
      BoxShadow(
        color: Color(0xff101111),
        offset: Offset(3, 3),
        blurRadius: 4,
      ),
      BoxShadow(
        color: Color(0xff25262b),
        offset: Offset(-3, -3),
        blurRadius: 4,
      ),
      BoxShadow(
        color: Color(0xffcbcbcb),
        offset: Offset(3, 3),
        blurRadius: 4,
        spreadRadius: -6,
      ),
      BoxShadow(
        color: Color(0xffffffff),
        offset: Offset(-3, -3),
        blurRadius: 4,
        spreadRadius: -6,
      ),
    ];
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[Text('Login Failure'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }

        if (state is LoginSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      builder: (context, state) {
        return Stack(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Positioned(
              top: mediaQuery.size.height * 0.1,
              child: Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  // color: Colors.grey[800],
                ),
                child: Image.asset(
                  'assets/robo.gif',
                  // height: 600,
                  // width: mediaQuery.size.width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: mediaQuery.size.height * 0.1,
              left: mediaQuery.size.width * 0.15,
              child: GestureDetector(
                onTap: () => BlocProvider.of<LoginBloc>(context).add(
                  LoginWithGooglePressed(),
                ),
                child: Container(
                  // height: 100,
                  // width: mediaQuery.size.width * 0.7,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: theme.backgroundColor,
                    borderRadius: BorderRadius.circular(18),
                    gradient: LinearGradient(
                      colors: [Color(0xff1c1d21), Color(0xff17181c)],
                      transform: GradientRotation(pi / 180 * 145),
                    ),
                    boxShadow: [
                      _shadowBox[0],
                      _shadowBox[1],
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.google,
                        size: 28,
                        color: theme.buttonColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Sign in with Google',
                        style: theme.textTheme.headline2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
