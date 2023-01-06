import 'package:flutter/foundation.dart';
import 'package:rider/constants/status.dart';
import 'package:rider/domain/auth.model.dart';
import 'package:rider/domain/user.model.dart';
import 'package:rider/utility/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationProvider with ChangeNotifier {
  AuthenticationProvider._();
  static final instance = AuthenticationProvider._();

  AuthenticationStatus status = AuthenticationStatus.unknown;

  User user = User.empty();
  String authToken = "";

  void authenticationChanged(AuthenticationStatus status) {
    this.status = status;
    notifyListeners();
  }

  void loginUser({required User user}) {
    this.user = user;
    authToken = user.token!;
    status = AuthenticationStatus.authenticated;
    notifyListeners();

    // User has been logged in and can be saved to shared prefs
    LoginData data = LoginData(user: user, authToken: authToken);

    //save user
    UserPreferences().storeLoginData(data);
  }

  void logout() async {
    status = AuthenticationStatus.unAuthenticated;
    user = User.empty();
    authToken = "";
    SharedPreferences.getInstance().then((pref) => pref.clear());
    notifyListeners();
  }

  void initialize({User? user, String? authToken}) {
    this.user = user ?? this.user;
    this.authToken = authToken ?? this.authToken;
  }
}
