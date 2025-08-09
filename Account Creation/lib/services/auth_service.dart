import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class AuthService {

  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore _database = FirebaseFirestore.instance;





  // sign up
  Future<void>  createAccount(String name, email, pw)async{
    try {

      await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: pw
      );

      String userid = _auth.currentUser!.uid;

      _database
      .collection('users')
      .doc(userid)
      .set({
        "id" : userid,
        "name" : name,
        "email" : email
      });
       
    } on FirebaseException   catch (e) {
      throw e.message!;
    }

  }


  // login
  Future<void> login(String email, pw)async{

    try {

      await _auth.signInWithEmailAndPassword(
        email: email, 
        password: pw
      );

      
    } on FirebaseAuthException   catch (e) {

      throw e.message ?? "Something went wrong" ;
      
    }

  }

  // sign out
  Future<void> logout()async{
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {

      throw e.message ?? "Something went wrong" ;
    }
  }

  // foreget password
  Future<void> forgetPw( String email)async{

    try {
      await _auth.sendPasswordResetEmail(email: email );
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Something went wrong" ;
    }

  }




  Future< Map<String,dynamic>? > getProfileData()async{
    try {

      var userDoc =  await _database
      .collection('users')
      .doc(_auth.currentUser!.uid)
      .get();


      if (userDoc.exists) {
        return userDoc.data(); 
      }
      else{
        throw Exception("User not found");
      }
      
    } on FirebaseException catch (error) {

      throw  error.message ?? "Something went wrong";
    
    }

  }
 
}