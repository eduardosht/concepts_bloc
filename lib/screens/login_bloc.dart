import 'dart:async';

class LoginBloc {

  final StreamController _streamController = StreamController();
  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  bool passwordVisible = false;
  String email = "";
  String password = "";
  bool loading = false;
  bool loggedIn = false;

  void setEmail(String value) {
    email = value;
    input.add(email);
  }

  void setPassword(String value) {
    password = value;
    input.add(password);
  }

  void togglePasswordVisibility() {
    passwordVisible = !passwordVisible;
    input.add(passwordVisible);
  }

  bool get isEmailValid =>
      RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
          .hasMatch(email);

  bool get isPasswordValid => password.length >= 6;

  Function get loginPressed =>
      (isEmailValid && isPasswordValid && !loading) ? login : null;

  bool get isFormValid => isEmailValid && isPasswordValid;

  Future<void> login() async {
    loading = true;
    input.add(loading);

    await Future.delayed(Duration(seconds: 2));

    loading = false;
    loggedIn = true;
    email = "";
    password = "";

    input.add(loggedIn);
    input.add(email);
    input.add(password);
  }
}