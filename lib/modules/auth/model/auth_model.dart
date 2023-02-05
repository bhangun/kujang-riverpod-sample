

class Authentication {
  Authentication({required this.username, required this.password, this.rememberMe=false});
  final String username;
  final String password;
  final bool rememberMe;
}

