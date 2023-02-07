import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/modules/app/model/status.dart';

import '../../../services/apps_routes.dart';
import '../../../services/auth_jwt_services.dart';
import '../../../services/navigation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../model/auth_model.dart';

final authProvider = StateNotifierProvider<AuthProvider, Authentication>(
    (ref) => AuthProvider());

class AuthProvider extends StateNotifier<Authentication> {
  AuthProvider()
      : super(const Authentication(
            username: 'cccc',
            password: ''));
   Authentication auth = const Authentication(username: '', password: '');

  bool canRegister() {

    return auth.username.isNotEmpty &&
        auth.password.isNotEmpty &&
        auth.confirmPassword.isNotEmpty;
    
  }

  bool canForgetPassword() {
    return !auth.status.hasErrorInForgotPassword && auth.username.isNotEmpty;
  }

  setUserId(String value) {
    _validateUserEmail(value);
    state.copyWith(username: value);
    //state = auth;
  }

  signUpDefault() {}

  void setPassword(String value) async {
    _validatePassword(value);
    state.copyWith(password: value);
    //state = auth;
  }

  void setConfirmPassword(String value) {
    _validateConfirmPassword(value);
    auth.copyWith(confirmPassword: value);
  }

  void _validateUserEmail(String value) {
    // Regex for email validation
    String pattern = "[a-zA-Z0-9+._%-+]{1,256}\\@"
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}"
        "(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+";
    print(value);
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
  print(state.username);
    state = auth;
  }

  void _validatePassword(String value) {
    if (value.isEmpty) {
      auth.copyWith(passwordMessage: "empty");
    } else if (value.length < 6) {
      auth.copyWith(passwordMessage: "length");
    } else {
      auth.copyWith(passwordMessage: '');
    }
    state = auth;
  }

  void _validateConfirmPassword(String value) {
    if (value.isEmpty) {
      auth.copyWith(confirmPasswordMessage: "confirm");
    } else if (value != auth.password) {
      auth.copyWith(confirmPasswordMessage: "match");
    } else {
      auth.copyWith(confirmPasswordMessage: '');
    }
    state = auth;
  }

  String messagePassword(context) {
    switch (auth.passwordMessage) {
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
    auth.copyWith(
        status: Status(
            errorMessage: AppLocalizations.of(context).errorUnauthorized));
    switch (auth.status.errorMessage) {
      case "unauthorized":
        auth.copyWith(
            status: Status(
                errorMessage: AppLocalizations.of(context).errorUnauthorized));
        break;
      case "username":
        return AppLocalizations.of(context).errorUsername;
      default:
        return AppLocalizations.of(context).errorNetwork;
    }
    state = auth;
  }

  signIn(context) {
    auth.copyWith(status: Status(errorMessage: message(context)));

    AuthServices.login(auth.username, auth.password, auth.rememberMe).then((v) {
      _loggedin(v);
    });

    state = auth;
  }

  void _loggedin(value) async {
    //int id = (await DatabaseServices.db.fetchObject(value))["user"];
    for (var user in await AuthServices.userStatic()) {
      /* if (user.id == id) {
        this.user = user;
      } */
    }

    NavigationServices.navigateTo(AppsRoutes.home);
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
    auth.copyWith(status: const Status(loading: true));
    state = auth;
  }

  Future gotoHome() async {
    if (auth.loggedIn) NavigationServices.navigateTo(AppsRoutes.home);
    state = auth;
  }

  Future forgotPassword() async {
    auth.copyWith(status: const Status(loading: true));
    state = auth;
  }

  void signUpWithGoogle() async {}

  void signUpWithFacebook() async {}

  void signUpWithApple() async {}

  void signUpWithTwitter() async {}

  Future<void> logout() async {
    auth.copyWith(status: const Status(loading: true));
    AuthServices.logout();
    NavigationServices.navigateTo(AppsRoutes.login);
    auth.copyWith(status: const Status(loading: false));
    state = auth;
  }
}
