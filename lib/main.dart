import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/main_screen.dart';

// тут ничего лишнего кроме этого коммента
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Baby',
      ),
      home: const MyHomePage(),
    );
  }
}
