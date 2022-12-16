import 'package:rider/domain/user.model.dart';
import 'package:rider/domain/rider.model.dart';

class LoginData {
  final User user;
  final String authToken;
  LoginData({required this.user, required this.authToken});
}

class RiderLogin {
  final Rider rider;
  RiderLogin({required this.rider});
}
