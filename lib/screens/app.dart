import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rider/providers/auth.provider.dart';
import 'package:rider/providers/order.provider.dart';
import 'package:rider/routes/app_router.dart';
import 'package:rider/screens/auth/login_screen.dart';
import 'package:rider/screens/auth/registration_screen.dart';
import 'package:rider/screens/auth/splash.dart';
import 'package:rider/screens/auth/welcome.dart';
import 'package:rider/screens/dashboard/dashboard.dart';
import 'package:rider/screens/home_screen.dart';
import 'package:rider/screens/profile/pages/profileEdit.dart';
import 'package:rider/screens/profile/profile.dart';

class Mealio extends StatefulWidget {
  const Mealio({super.key});

  @override
  State<Mealio> createState() => _MealioState();
}

class _MealioState extends State<Mealio> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthenticationProvider.instance,
        ),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        
      ],
      child: MaterialApp(
        title: 'Meal-io',
        theme: ThemeData(fontFamily: GoogleFonts.lato().fontFamily),
        initialRoute: AppRoute.splash,
        routes: {
          AppRoute.splash: (context) => const SplashScreen(),
          AppRoute.welcome: (context) => const WelcomeScreen(),
          AppRoute.register: (context) => RegistrationScreen(),
          AppRoute.login: (context) => LoginScreen(),
          AppRoute.home: (context) => const Home(),
          AppRoute.dashboard: ((context) => const DashboardScreen()),
          AppRoute.profile: (context) => const Profile(),
          AppRoute.profileEdit: (context) => const ProfileEdit(),
        },
      ),
    );
  }
}
