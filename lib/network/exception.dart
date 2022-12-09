class APIException implements Exception {
  final String? _message;
  final String? _prefix;

  APIException([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataException extends APIException {
  FetchDataException([String? message]) : super(message, 'Error During Communication: ');
}

class BadRequestException extends APIException {
  BadRequestException([String? message]) : super(message, 'Invalid Request: ');
}

class UnauthorisedException extends APIException {
  UnauthorisedException([String? message]) : super(message, 'Unauthorised: ');
}

class InvalidInputException extends APIException {
  InvalidInputException([String? message]) : super(message, 'Invalid Input: ');
}
