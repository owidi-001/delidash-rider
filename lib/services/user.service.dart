
import 'package:rider/domain/exception.dart';
import 'package:rider/domain/user.model.dart';
import 'package:rider/routes/app_router.dart';
import 'package:rider/services/http_client.dart';

class UserService {
  // login
  Future<HttpResult<User>> login({required Map<String, String> data}) =>
      HttpClient.post2<User>(
        ApiUrl.login,
        data: data,
        der: (data) => User.fromJson(data),
      );

  // register
  Future<HttpResult<User>> register({required Map<String, String> data}) =>
      HttpClient.post2<User>(
        ApiUrl.register,
        data: data,
        der: (data) => User.fromJson(data),
      );

  // // Update profile
  Future<HttpResult<User>> updateProfile({required Map<String, String> data}) =>
      HttpClient.post2<User>(
        ApiUrl.profileUpdate,
        data: data,
        der: (data) => User.fromJson(data),
      );

    
}
