import 'package:dio/dio.dart';
import 'package:exam2_flutter/model/people_model.dart';

abstract class PeopleService {
  Dio dio = Dio();
  late Response response;
  String baseurl = "https://664dcb37ede9a2b55654e96c.mockapi.io/api/v1/people";

  Future<List<People>> getData();
}

class PeopleServiceImp extends PeopleService {
  @override
  Future<List<People>> getData() async {
    response = await dio.get(baseurl);
    if (response.statusCode == 200) {
      List<People> peopleData = List.generate(response.data.length,
          (index) => People.fromMap(response.data[index]));

      //print(peopleData);
      return peopleData;
    } else {
      print("not get people data");
      return [];
    }
  }
}
