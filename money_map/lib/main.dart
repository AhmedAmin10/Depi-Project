import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'Screens/splash_screen.dart';
import 'models/data.dart';


void main() async {
  await Hive.initFlutter();
  await Hive.openBox("expense_database");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Data(),
      builder: (context, child) => const MaterialApp(
        title: 'Money Map',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(), // Start with Splash Screen
      ),
    );
  }
}
