class ApiException implements Exception {
  String title;
  String eMsg;

  ApiException({required this.title, required this.eMsg});

  String toErrorMsg() {
    return "$title : $eMsg";
  }
}

class FetchDataException extends ApiException {
  FetchDataException({required String errorMsg})
      : super(title: "Network Error", eMsg: errorMsg);
}

class BadRequestException extends ApiException {
  BadRequestException({required String errorMsg})
      : super(title: "Invalid Request", eMsg: errorMsg);
}

class BadResponseException extends ApiException {
  BadResponseException({required String errorMsg})
      : super(title: "Invalid Response", eMsg: errorMsg);
}

class UnauthorisedException extends ApiException {
  UnauthorisedException({required String errorMsg})
      : super(title: "Unauthorised", eMsg: errorMsg);
}

class InvalidInputException extends ApiException {
  InvalidInputException({required String errorMsg})
      : super(title: "InvalidInput", eMsg: errorMsg);
}
