import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/helper/helper_function.dart';
import 'package:firebase_app/pages/login.dart';
import 'package:firebase_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService _authService = AuthService();


  Uint8List? image;
  String? imageName;
  ImagePicker picker = ImagePicker();

  SupabaseClient supabase = Supabase.instance.client;

  FirebaseFirestore  _database = FirebaseFirestore.instance;

  FirebaseAuth _auth = FirebaseAuth.instance;



  void pickImage()async{

    var pickedImage = await picker.pickImage(source: ImageSource.gallery );
    
    if (pickedImage != null) {
      image = await  pickedImage.readAsBytes();
      imageName = pickedImage.name;

      showLoading(context);


      // upload picked image to supabase storage
      await supabase.storage
      .from('profile-pic')
      .uploadBinary("profile_images/$imageName", image!);


      // now we will get the download url of the picture
      String imageUrl = supabase.storage.from('profile-pic').getPublicUrl("profile_images/$imageName");


      // now we will save this url in user doc in firebase
      await _database
      .collection('users')
      .doc(_auth.currentUser!.uid)
      .update({
        "imageUrl" : imageUrl
      });

      hideLoading(context);


      showNotification("Success", "Profile Picture updated!", context);

      setState(() {
        
      });
      
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),

      body: FutureBuilder(
        future: _authService.getProfileData(), 
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {

            return Center(child: CircularProgressIndicator(),);
            
          }

          else if( snapshot.hasError){

            return Center(child: Text(snapshot.error.toString()),);

          }
          
          else{

            var data = snapshot.data;

            return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            // image
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                
                CircleAvatar(
                  
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.black,
                  radius: 45,

                  backgroundImage:  image != null  ?  MemoryImage(image!)  :   NetworkImage(data!['imageUrl'])   ,


                  child: 

                  image == null
                  
                  ? data!['imageUrl'] != null ? null : Text( data['name'][0].toString().toUpperCase()    , style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)

                  : null
                ),


                InkWell(
                  onTap: () {
                    pickImage();
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.blue.shade900,
                    foregroundColor: Colors.white,
                    radius: 12,
                    child: Icon(Icons.camera_alt_outlined, size: 14),
                  ),
                ),


              ],
            ),

            SizedBox(height: 5,),


            // name
            Text( data!['name']   , style: TextStyle(fontSize: 15,),),

            // email
            Text( data['email'] , style: TextStyle(fontSize: 12, color: Colors.grey),),

            SizedBox(height: 15,),

            
            // edit profile
            Card(
              elevation: 0,
              color: Colors.blue.shade100,
              child: ListTile(
                leading: Icon(Icons.edit),
                title: Text("Edit Profile"),
                trailing: Icon(Icons.chevron_right),
              ),

            ),

            SizedBox(height: 10,),


            // change pasword
            Card(
              elevation: 0,
              color: Colors.blue.shade100,
              child: ListTile(
                leading: Icon(Icons.lock_outline),
                title: Text("Change Password"),
                trailing: Icon(Icons.chevron_right),
              ),

            ),

            SizedBox(height: 10,),


            // sign out
            Card(
              elevation: 0,
              color: Colors.red.shade100,
              child: ListTile(

                onTap: () {
                  
                     showLoading(context);

              _authService
              .logout()
              .then((value){
                hideLoading(context);
                gotoPageAndRemoveAll(LoginPage(), context);
              })
              .catchError((error){
                hideLoading(context);
                showNotification("Failed", error , context, isError: true);
              })
              ;
                    
                },

                leading: Icon(Icons.logout),
                title: Text("Sign out"),
                trailing: Icon(Icons.chevron_right),
              ),

            ),


          ],
        ),
      );


          }

        },
      )
    );
  }
}