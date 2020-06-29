import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:notably/user_repository.dart';
import 'package:notably/blocs/login/login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepository;

  LoginBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  LoginState get initialState => LoginEmpty();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginWithGooglePressed) {
      try {
        await _userRepository.signInWithGoogle();
        yield LoginSuccess();
      } catch (_) {
        yield LoginFailure();
      }
    }
  }
}
