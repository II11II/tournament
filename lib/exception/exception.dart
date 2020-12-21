class ServerErrorException implements Exception {
  var cause;

  ServerErrorException([this.cause]);
  @override
  String toString() {
    return "${(ServerErrorException).toString()}: $cause";
  }
}

class UserExistException implements Exception {
  var cause;

  UserExistException([this.cause]);
  @override
  String toString() {
    return "${(UserExistException).toString()}: $cause";
  }
}

class InvalidTokenException implements Exception {
  var cause;

  InvalidTokenException([this.cause]);
  @override
  String toString() {
    return "${(InvalidTokenException).toString()}: $cause";
  }
}

class InvalidCodeException implements Exception {
  var cause;

  InvalidCodeException([this.cause]);
  @override
  String toString() {
    return "${(InvalidCodeException).toString()}: $cause";
  }
}

class InvalidLoginPasswordException implements Exception {
  var cause;

  InvalidLoginPasswordException([this.cause]);

  @override
  String toString() {
    return "${(InvalidLoginPasswordException).toString()}: $cause";
  }
}

class UnauthorisedException implements Exception {}
class InvalidCardCredentialsException implements Exception {
  var cause;

  InvalidCardCredentialsException([this.cause]);

  @override
  String toString() {
    return "${(InvalidCardCredentialsException).toString()}: $cause";
  }
}