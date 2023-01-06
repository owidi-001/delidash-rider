import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rider/domain/auth.model.dart';
import 'package:rider/providers/auth.provider.dart';
import 'package:rider/providers/rider.provider.dart';
import 'package:rider/routes/app_router.dart';
import 'package:rider/theme/app_theme.dart';
import 'package:rider/utility/shared_preference.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // late AppService _appService;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), initializeApp);
    // initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff23AA49),
      body: Center(
          child: Container(
        decoration: const BoxDecoration(
            color: AppTheme.lightColor,
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 48,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: Image.asset(
                "assets/images/app_logo.png",
                scale: 4.0,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      )),
    );
  }

  Future<void> initializeApp() async {
    LoginData? data = await UserPreferences().loadUserData();
    RiderLogin? data2 = await UserPreferences().loadRiderData();

    if (!mounted) {
      return;
    }
    if (data == null || data2 == null) {
      // Go to welcome screen
      Navigator.pushReplacementNamed(context, AppRoute.welcome);
    } else {
      context.read<AuthenticationProvider>().loginUser(
            user: data.user,
          );

      context.read<RiderProvider>().loginRider(rider: data2.rider);

      Navigator.pushReplacementNamed(context, AppRoute.home);
    }
  }
}
