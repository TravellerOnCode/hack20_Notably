import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:notably/blocs/login/login.dart';

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      icon: Icon(FontAwesomeIcons.google, color: theme.buttonColor),
      onPressed: () {
        BlocProvider.of<LoginBloc>(context).add(
          LoginWithGooglePressed(),
        );
      },
      label: Text(
        'Sign in with Google',
        style: theme.textTheme.headline2,
      ),
      color: theme.backgroundColor,
    );
  }
}
