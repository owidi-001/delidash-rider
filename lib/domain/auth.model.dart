import 'package:rider/domain/rider.dart';

class LoginData {
  final User user;
  final String authToken;
  LoginData({required this.user, required this.authToken});
}
