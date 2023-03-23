import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../model/status.dart';
import '../../../services/auth_jwt_services.dart';
import '../model/auth_model.dart';

final authProvider = StateNotifierProvider<AuthProvider, Authentication>(
    (ref) => AuthProvider(ref: ref));

class AuthProvider extends StateNotifier<Authentication> {
  Ref ref;
  AuthProvider({required this.ref})
      : super(const Authentication(username: '', password: ''));

  bool canRegister() {
    return state.username.isNotEmpty &&
        state.password.isNotEmpty &&
        state.confirmPassword.isNotEmpty;
  }

  bool canForgetPassword() {
    return !state.status.hasErrorInForgotPassword && state.username.isNotEmpty;
  }

  void setUserId(String value) {
    //state.copyWith(username: value);
    state.copyWith(token: value);
    //_validateUserEmail(value);
  }

  signUpDefault() {}

  void setPassword(String value) async {
    _validatePassword(value);
    state.copyWith(password: value);
    //
  }

  void setConfirmPassword(String value) {
    _validateConfirmPassword(value);
    state.copyWith(confirmPassword: value);
  }

  void _validateUserEmail(String value) {
    state.copyWith(username: 'val> $value');
    // Regex for email validation
    String pattern = "[a-zA-Z0-9+._%-+]{1,256}\\@"
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}"
        "(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+";

    RegExp regExp = RegExp(pattern);

    if (value.isEmpty) {
      state.copyWith(loginMessage: "empty");
    } else if (regExp.hasMatch(value)) {
      state.copyWith(status: const Status(showError: true));
      state.copyWith(loginMessage: '');
    } else {
      state.copyWith(status: const Status(showError: true));
      state.copyWith(loginMessage: 'unauthorized');
    }

    // state.copyWith(loginMessage: value);
    // print('<<login<< ${state.loginMessage}');
    // print('<<<< ${state.toString()}');
  }

  void _validatePassword(String value) {
    if (value.isEmpty) {
      state.copyWith(passwordMessage: "empty");
    } else if (value.length < 6) {
      state.copyWith(passwordMessage: "length");
    } else {
      state.copyWith(passwordMessage: '');
    }
  }

  void _validateConfirmPassword(String value) {
    if (value.isEmpty) {
      state.copyWith(confirmPasswordMessage: "confirm");
    } else if (value != state.password) {
      state.copyWith(confirmPasswordMessage: "match");
    } else {
      state.copyWith(confirmPasswordMessage: '');
    }
  }

  String messagePassword(context) {
    switch (state.passwordMessage) {
      case "confirm":
        return AppLocalizations.of(context).passwordConfirm;
      case "empty":
        return AppLocalizations.of(context).passwordEmpty;
      case "length":
        return AppLocalizations.of(context).passwordLength;
      case "match":
        return AppLocalizations.of(context).passwordMatch;
      default:
        return "";
    }
  }

  message(context) {
    state.copyWith(
        status: Status(
            errorMessage: AppLocalizations.of(context).errorUnauthorized));
    switch (state.status.errorMessage) {
      case "unauthorized":
        state.copyWith(
            status: Status(
                errorMessage: AppLocalizations.of(context).errorUnauthorized));
        break;
      case "username":
        return AppLocalizations.of(context).errorUsername;
      default:
        return AppLocalizations.of(context).errorNetwork;
    }
  }

  signIn(context) {
    state.copyWith(status: Status(errorMessage: message(context)));

    AuthServices.login(state.username, state.password, state.rememberMe)
        .then((v) {
      _loggedin(v);
    });
  }

  void _loggedin(value) async {
    //int id = (await DatabaseServices.db.fetchObject(value))["user"];
    for (var user in await AuthServices.userStatic()) {
      /* if (user.id == id) {
        this.user = user;
      } */
    }

   // NavigationServices.navigateTo(AppsRoutes.home);
    /* if (value == 'SUCCESS') {
      FLog.info(text: "Success login!");
      NavigationServices.navigateTo(AppsRoutes.home);
    } else if (value.toString().contains("[401]")) {
      showError = true;
      loading = false;
      errorMessage = "unauthorized";
    } else if (value.toString().contains("[400]")) {
      showError = true;
      loading = false;
      errorMessage = "username";
    } */
  }

  Future register() async {
    state.copyWith(status: const Status(loading: true));
  }

  Future gotoHome() async {
   // if (state.loggedIn) NavigationServices.navigateTo(AppsRoutes.home);
  }

  Future forgotPassword() async {
    state.copyWith(status: const Status(loading: true));
  }

  void signUpWithGoogle() async {}

  void signUpWithFacebook() async {}

  void signUpWithApple() async {}

  void signUpWithTwitter() async {}

  Future<void> logout() async {
    state.copyWith(status: const Status(loading: true));
    AuthServices.logout();
   // NavigationServices.navigateTo(AppsRoutes.login);
    state.copyWith(status: const Status(loading: false));
  }
}
