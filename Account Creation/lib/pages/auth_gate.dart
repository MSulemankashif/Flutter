import 'package:firebase_app/pages/home.dart';
import 'package:firebase_app/pages/login.dart';
import 'package:firebase_app/pages/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(

      stream:  FirebaseAuth.instance.authStateChanges() , 

      builder: (context, snapshot) {
        if (snapshot.hasData) {
          
          return HomePage();

        } else {
          return RegisterPage();
        }
      },
    );
  }
}