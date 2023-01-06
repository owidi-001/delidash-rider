import 'package:flutter/material.dart';
import 'package:rider/screens/dashboard/dashboard.dart';
import 'package:rider/screens/profile/profile.dart';
import 'package:rider/theme/app_theme.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _screens = [const DashboardScreen(), const Profile()];

  void _updateIndex(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  final List<BottomNavigationBarItem> navItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
    BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.whiteColor,
        body: _screens[_currentIndex],
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
            color: AppTheme.lightColor,
          ),
          child: BottomNavigationBar(
            onTap: _updateIndex,
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppTheme.primaryColor,
            unselectedItemColor: AppTheme.secondaryColor,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(color: AppTheme.primaryColor),
            items: navItems,
          ),
        ));
  }
}
