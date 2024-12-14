class ConnectionTimeout implements Exception {}

class InvalidToken implements Exception {}

class WrongCredentials implements Exception {}

class ServerError implements Exception {}

class CustomError implements Exception {
  final String message;
  // final int error;

  CustomError(this.message);
  
}
