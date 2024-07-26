// ignore_for_file: public_member_api_docs, sort_constructors_first

class ResultModel {}

class SucessModel extends ResultModel {}

class ErrorModel extends ResultModel {
  String msg;
  ErrorModel({
    required this.msg,
  });
}

class ExceptionModel extends ResultModel {
  String msg = "lm";
  ExceptionModel({
    required this.msg,
  });
}

class ListOf<T> extends ResultModel {
  List<T> listData;
  ListOf({
    required this.listData,
  });
}
