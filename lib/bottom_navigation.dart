import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'image_picker.dart';
import 'login_page.dart';
import 'main.dart';
import 'settingPage.dart';

class BottomNavBar extends StatefulWidget {
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final RxInt currentIndex = 0.obs;
  final List<Widget> _pages = [
    MyHomePage(),
    LoginPage(),
    PickImage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex.value], // Use value of currentIndex
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff5654a2),
        elevation: double.maxFinite,
        currentIndex: currentIndex.value,
        onTap: (index) {
          currentIndex.value = index;
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
