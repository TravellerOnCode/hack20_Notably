import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notably/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:notably/blocs/theme_bloc/theme_bloc.dart';

import 'package:notably/screens/screen.dart';
import 'package:notably/screens/login_screen.dart';
import 'package:notably/simple_bloc_delegate.dart';
import 'package:notably/user_repository.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc()..add(DarkThemeEvent()),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) =>
              AuthenticationBloc(userRepository: userRepository)
                ..add(AppStarted()),
        ),
      ],
      child: App(
        userRepository: userRepository,
      ),
    ),
  );
}

class App extends StatefulWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ThemeBloc, ThemeState>(
      listener: (context, state) {
        if (state is DarkThemeState) {
          setState(() {
            _theme = state.theme;
          });
          print(state.theme.toString());
        } else if (state is LightThemeState) {
          setState(() {
            _theme = state.theme;
          });
        }
      },
      child: MaterialApp(
        theme: _theme,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is Uninitialized) {
              return SplashScreen();
            }
            if (state is Unauthenticated) {
              return LoginScreen(userRepository: widget._userRepository);
            }
            if (state is Authenticated) {
              return HomeScreen(name: state.displayName);
            }
          },
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
