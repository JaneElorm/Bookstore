import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; 
import 'homepage/Homepage.dart';
import 'login/login.dart';
import 'login/sign_up.dart';
import 'login/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(MyApp());
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'Bookstore App', 
      // theme: ThemeData(
      //   primarySwatch: Colors.brown, 
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      home: SplashScreen(), 
      routes: {
        // '/login': (context) => LoginPage(),
        // '/signup': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
