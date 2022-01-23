import 'package:flutter/material.dart';

class ForgotPasswordState {
  TextEditingController? email;
  GlobalKey<FormState>? formKey;

  ForgotPasswordState({
    this.email,
    this.formKey,
  });

  factory ForgotPasswordState.initialState() {
    return ForgotPasswordState(
      email: TextEditingController(),
      formKey: GlobalKey<FormState>(),
    );
  }

  ForgotPasswordState copyWith({
    TextEditingController? email,
    GlobalKey<FormState>? formKey,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      formKey: formKey ?? this.formKey,
    );
  }
}
