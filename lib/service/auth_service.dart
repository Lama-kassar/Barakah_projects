/*
import 'package:dio/dio.dart';

abstract class AuthService {
  Dio req = Dio();
  late Response response;
  String baseurl = "https://664dcb37ede9a2b55654e96c.mockapi.io/api/v1/people";

  Future<bool> logIn(UserLoginModel user);
}

class AuthSeviceImp extends AuthService {
  @override
  Future<bool> logIn(UserLoginModel user) async {
    try {
      response = await req.post(baseurl, data: user.toMap());
      if (response.statusCode == 200) {
        core
            .get<SharedPreferences>()
            .setString('token', response.data['token']);
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      print(e.message);
      return false;
    }
  }
}
*/