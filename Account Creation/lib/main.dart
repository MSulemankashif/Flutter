import 'package:firebase_app/pages/auth_gate.dart';
import 'package:firebase_app/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';


void main()async {

  await Supabase.initialize(
    url: "https://iklgdcjwgldqebposbyh.supabase.co", 
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlrbGdkY2p3Z2xkcWVicG9zYnloIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQzOTkwNDMsImV4cCI6MjA2OTk3NTA0M30.ieo8_PFI4ObTjCH1OpKsiLqOrh0vFL5VEDyXWNAJ4bA"
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}
