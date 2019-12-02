import 'package:flutter/material.dart';
import 'package:bloon_pro/authentification/auth.dart';
import 'package:bloon_pro/authentification/root_page.dart';
import 'package:provider/provider.dart';
import 'adminProfile.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'myClubs.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  final primaryColor = const Color(0xFF7854d3);
  final accentColor = const Color(0xFF6f43e0);

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      child: MaterialApp(
        title: 'Bloon Pro',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: accentColor,
        fontFamily: 'Comfortaa',
      ),
        routes: {
          '/': (BuildContext context) => new RootPage(auth: new Auth()),
          '/adminProfil' : (BuildContext context) => AdminProfil(),
          '/myClubs' : (BuildContext context) => MyClubs(),
        },
      ),
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider<DrawerStateInfo>(
            builder: (_) => DrawerStateInfo()),
      ],
    );
  }
}

class DrawerStateInfo with ChangeNotifier {
  int _currentDrawer = 0;

  int get getCurrentDrawer => _currentDrawer;

  void setCurrentDrawer(int drawer) {
    _currentDrawer = drawer;
    notifyListeners();
  }

  void increment() {
    notifyListeners();
  }
}
