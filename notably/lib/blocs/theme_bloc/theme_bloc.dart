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

abstract class ThemeState extends Equatable {
  final shadows;
  const ThemeState(this.shadows);

  @override
  List<Object> get props => [shadows];
}

class LightThemeState extends ThemeState {
  final ThemeData theme;

  final List<BoxShadow> shadows;

  LightThemeState(this.theme, this.shadows) : super(shadows);

  @override
  List<Object> get props => [theme, shadows];
}

class DarkThemeState extends ThemeState {
  final ThemeData theme;

  final List<BoxShadow> shadows;
  DarkThemeState(this.theme, this.shadows) : super(shadows);

  @override
  List<Object> get props => [theme, shadows];
}

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState => LightThemeState(
        ThemeData.light().copyWith(
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
        [
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
        ],
      );

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is LightThemeEvent) {
      yield LightThemeState(
        ThemeData.light().copyWith(
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
        [
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
        ],
      );
    } else {
      yield DarkThemeState(
        ThemeData.dark().copyWith(
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
        [
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
        ],
      );
    }
  }
}
