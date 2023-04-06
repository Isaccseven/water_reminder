import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:water_reminder/core/color_constants.dart';
import 'package:water_reminder/dashboard/dashboard.dart';
import 'package:water_reminder/home/home_page.dart';
import 'package:water_reminder/model/fluid.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  late Future<void> _initHive;

  List<Widget> screens = [
    HomePage(),
    Dashboard(),
    const Text('Profile'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> initBox() async {
    await Hive.initFlutter();
    await Hive.openBox('fluids');
  }

  @override
  void initState() {
    super.initState();
    _initHive = initBox();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initHive,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            home: Scaffold(
              body: screens[_selectedIndex],
              bottomNavigationBar: buildBottomNavigationBar(),
            ),
          );
        } else {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: ColorConstants.backgroundColor.color,
      elevation: 0,
      currentIndex: _selectedIndex,
      onTap: (index) => _onItemTapped(index),
      items: [
        buildBottomNavigationBarItem(Icons.water_drop),
        buildBottomNavigationBarItem(Icons.circle_outlined),
        buildBottomNavigationBarItem(Icons.settings),
      ],
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(IconData icon) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      label: '',
    );
  }
}
