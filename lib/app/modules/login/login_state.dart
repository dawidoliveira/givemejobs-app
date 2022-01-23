import 'package:flutter/material.dart';

class LoginState {
  TextEditingController? email;
  TextEditingController? pass;
  GlobalKey<FormState>? formKey;

  LoginState({
    this.email,
    this.pass,
    this.formKey,
  });

  factory LoginState.initialState() {
    return LoginState(
      email: TextEditingController(),
      pass: TextEditingController(),
      formKey: GlobalKey<FormState>(),
    );
  }

  LoginState copyWith({
    TextEditingController? email,
    TextEditingController? pass,
    GlobalKey<FormState>? formKey,
  }) {
    return LoginState(
      email: email ?? this.email,
      pass: pass ?? this.pass,
      formKey: formKey ?? this.formKey,
    );
  }
}
