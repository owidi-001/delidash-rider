// Save token to local device
import 'dart:convert';

import 'package:rider/domain/auth.model.dart';
import 'package:rider/domain/user.model.dart';
import 'package:rider/domain/rider.model.dart';
import 'package:rider/utility/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  // load shared preferences
  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

// Load User data
  Future<LoginData?> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? user = prefs.getString(USER);
    String? rider = prefs.getString(RIDER);
    String? authToken = prefs.getString(TOKEN);

    if (user != null && authToken != null) {
      return LoginData(
        user: User.fromJson(
          json.decode(user),
        ),
        authToken: authToken,
      );
    }
    return null;
  }

  Future<RiderLogin?> loadRiderData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? rider = prefs.getString(RIDER);

    if (rider != null) {
      return RiderLogin(
        rider: Rider.fromJson(
          json.decode(rider),
        ),
      );
    }
    return null;
  }

  // Store user
  void storeLoginData(LoginData data) async {
    await SharedPreferences.getInstance().then((pref) {
      pref.setString(USER, jsonEncode(data.user.toMap()));
      pref.setString(TOKEN, data.authToken);
    });
  }

  // Store rider
  void storeRiderLogins(RiderLogin data) async {
    await SharedPreferences.getInstance().then((pref) {
      pref.setString(RIDER, jsonEncode(data.rider.toMap()));
    });
  }

  // Retrieve auth token from prefs
  Future<String> getToken() async {
    String data = await prefs.then((value) => value.getString(TOKEN)) ?? "";
    return data;
  }
}
