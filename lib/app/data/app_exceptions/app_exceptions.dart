class AppExceptions implements Exception {
  final _message;

  AppExceptions(this._message);

  @override
  String toString() {
    return " $_message";
  }
}

class FetchDataExceptions extends AppExceptions {
  FetchDataExceptions([String? message]) : super(message);
}

class BadRequestExceptions extends AppExceptions {
  BadRequestExceptions([String? message]) : super(message);
}

class InvalidInputException extends AppExceptions {
  InvalidInputException([String? message]) : super(message);
}
