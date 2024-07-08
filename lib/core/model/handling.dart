class ResultModel {}

class ErrorModel extends ResultModel {
  String message;
  ErrorModel({
    required this.message,
  });
}

class ExceptionModel extends ResultModel {
  String message;
  ExceptionModel({
    required this.message,
  });
}

class ListOf<T extends ResultModel> extends ResultModel {
  ListOf<T> data;
  ListOf({
    required this.data,
  });
}

class SuccessModel extends ResultModel {
  String message;
  SuccessModel({
    required this.message,
  });
}
