import 'package:flutter/foundation.dart';
import 'package:rider/constants/status.dart';
import 'package:rider/domain/auth.model.dart';
import 'package:rider/domain/rider.model.dart';
import 'package:rider/utility/shared_preference.dart';


class RiderProvider with ChangeNotifier {
  RiderProvider._();
  static final instance = RiderProvider._();

  AuthenticationStatus status = AuthenticationStatus.unknown;
  
  Rider rider = Rider.empty();

  void authenticationChanged(AuthenticationStatus status) {
    this.status = status;
    notifyListeners();
  }



  void loginRider({required Rider rider}) {
    this.rider = rider;
    status = AuthenticationStatus.authenticated;
    notifyListeners();

    // User has been logged in and can be saved to shared prefs
    RiderLogin data = RiderLogin(rider: rider);

      //save user
      UserPreferences().storeRiderLogins(data);
  }
}