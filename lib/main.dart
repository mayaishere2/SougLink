import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'market_owner/Stocklevel.dart';
import 'package:flutter/foundation.dart'; // Needed for kIsWeb

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    // Firebase configuration for Web
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDl05Wfav1tN5ijr44WOp_ZjI0C154KvV0",
        authDomain: "SougLink.firebaseapp.com",
        projectId: "souglink-9df24",
        storageBucket: "SougLink.appspot.com",
        messagingSenderId: "763894853613",
        appId: "1:763894853613:android:d83c6acb98ce59c4b8c1e4",
      ),
    );
  } else {
    // Firebase initialization for Mobile (Android/iOS)
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stocklevel(),
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar', ''),
      supportedLocales: const [
        Locale('en', ''),
        Locale('ar', ''),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
