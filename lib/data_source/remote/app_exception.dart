class AppException implements Exception{
  String title;
  String body;

  AppException({required this.title, required this.body});

  String toErrorMsg(){
    return "$title: $body";
  }
}

class FetchDataException extends AppException {
  FetchDataException({required String body})
      : super(title: "Error During Communication", body: body);
}

class BadRequestException extends AppException {
  BadRequestException({required String body})
      : super(title: "Invalid Request", body: body);
}

class UnauthorisedException extends AppException {
  UnauthorisedException({required String body})
      : super(title: "Unauthorised", body: body);
}

class InvalidInputException extends AppException {
  InvalidInputException({required String body})
      : super(title: "Invalid Input", body: body);
}
