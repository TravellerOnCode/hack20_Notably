import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class DarkThemeEvent extends ThemeEvent {}

class LightThemeEvent extends ThemeEvent {}

class ThemeState {
  final ThemeData theme;

  const ThemeState({@required this.theme}) : assert(theme != null);

  factory ThemeState.light() {
    return ThemeState(
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.red[300],
        accentColor: Colors.red[700],
        backgroundColor: Colors.white,
        buttonColor: Colors.white70,
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.white,
            fontSize: 32,
          ),
          headline2: TextStyle(
            color: Colors.white70,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  factory ThemeState.dark() {
    return ThemeState(
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.red[300],
        accentColor: Colors.red[700],
        backgroundColor: Color(0xff1a1b1f),
        buttonColor: Colors.white70,
        textTheme: TextTheme(
          headline1: TextStyle(
            color: Colors.white,
            fontSize: 32,
          ),
          headline2: TextStyle(
            color: Colors.white70,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState => ThemeState.dark();

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is LightThemeEvent) {
      yield ThemeState.light();
    } else {
      yield ThemeState.dark();
    }
  }
}
