import 'package:flutter/foundation.dart';

@immutable
class Status {
  const Status(
      {this.success = false,
      this.showError = false,
      this.loading = false,
      this.errorMessage = '',
      this.hasErrorInForgotPassword = false,
      this.hasErrorsInLogin = false});

  final bool success;
  final bool loading;
  final bool showError;
  final String errorMessage;
  final bool hasErrorInForgotPassword;
  final bool hasErrorsInLogin;
}
