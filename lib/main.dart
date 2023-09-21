import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_tiffin/asistantMethods/cartItemCounter.dart';
import 'package:my_tiffin/globalVariables/globleVariable.dart';
import 'package:my_tiffin/splashScreen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Menu>(create: (_) => Menu()),
        ChangeNotifierProvider(create: (c)=> CartItemCounter())

      ],
      child: MaterialApp(
        title: 'Staff App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MySplashScreen(),
      ),
    );
  }
}
