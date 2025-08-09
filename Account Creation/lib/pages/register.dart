import 'package:firebase_app/helper/helper_function.dart';
import 'package:firebase_app/pages/login.dart';
import 'package:firebase_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {

  RegisterPage({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 15,
          children: [
            // ICON
            Icon(Icons.person_add, size: 80, color: Colors.blue,),
        
        
            // REGISTER
            Text("Sign Up", style:TextStyle(fontSize: 25, fontWeight: FontWeight.bold) ,),
            Text("Create your Account",  style:TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold) ),


            SizedBox(height: 25,),
        
        
        
            // FORM (Name, email, password)
            Form(
              key: _formKey,
              child: Column(
                spacing: 15,
                children: [
        
                  // name field
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100)
                      ),
                      hintText: "Enter Name",
                      fillColor: Colors.grey.shade400,
                      filled: true,
                    ),
                    validator: (input){
                      if (input!.isEmpty) {
                        return "Name is required";
                      } 
                    },
                    
                  ),
        
        
                  // email field
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100)
                      ),
                      hintText: "Enter Email",
                      fillColor: Colors.grey.shade400,
                      filled: true,
                    ),
                    validator: (input){
                      if (input!.isEmpty) {
                        return "Email is required";
                      }
                      else if(  !input.contains("@")  ||  !input.contains(".com") ){
                        return "Email is not valid";
                      } 
                    },
                  ),
        
        
        
                  // password field
                  TextFormField(
                    controller: pwController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100)
                      ),
                      hintText: "Enter Password",
                      fillColor: Colors.grey.shade400,
                      filled: true,
                    ),
                    validator: (input){
                      if (input!.isEmpty) {
                        return "Password is required";
                      }
                      else if(input.length < 6){
                        return "password should be atlease 6 digits";
                      } 
                    },
                  ),
        
        
                ],
              ),
            ),



        
        
        
        
        
            // BUTTON
            SizedBox(
              height: 45,
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: ()async{

                  if (_formKey.currentState!.validate()) {

                    showLoading(context);

                    await _authService.createAccount(
                      nameController.text, 
                      emailController.text, 
                      pwController.text
                    ).then((value){
                      hideLoading(context);
                      showNotification("Success", "Account created", context);

                    }).catchError( (error){
                      hideLoading(context);
                      showNotification("Error", error, context, isError: true);
                    })  ;
                  }
              
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white), 
                label: Text("Create Account"),
                icon: Icon(Icons.login),
              ),
            ),
        
        
            // ALREADY HAVE AN ACCOUNT
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),

                GestureDetector(
                  onTap: () {
                    gotoPage(LoginPage(), context);
                  },

                  child: Text(
                  "Login", 
                  style: TextStyle(
                    color: Colors.blue, 
                    fontWeight: FontWeight.bold, 
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                    decorationThickness: 3
                  ), 
                ),
                )
              ],
            )

          ],
        ),
      ),
    );
  }
}