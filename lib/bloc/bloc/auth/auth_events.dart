abstract class AuthenticationEvent {
  const AuthenticationEvent();
}

class AuthenticationLogIn extends AuthenticationEvent {
  const AuthenticationLogIn({
    required this.login,
    required this.password,
    this.onError,
    this.onSuccess,
  });

  final String login;
  final String password;
  final Function? onError;
  final Function? onSuccess;
}

class AuthenticationLoading extends AuthenticationEvent {
  const AuthenticationLoading({
    this.loading,
  });

  final bool? loading;
}

class AuthenticationLogout extends AuthenticationEvent {
  const AuthenticationLogout({
    this.onSuccess,
  });

  final Function? onSuccess;
}

class AuthenticationInit extends AuthenticationEvent {
  const AuthenticationInit({
    required this.onSuccess,
    required this.onError,
  });

  final Function onSuccess;
  final Function onError;
}
