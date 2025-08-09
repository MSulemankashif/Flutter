import 'package:firebase_app/helper/helper_function.dart';
import 'package:firebase_app/pages/home.dart';
import 'package:firebase_app/pages/register.dart';
import 'package:firebase_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatelessWidget {

  ForgetPasswordPage({super.key});

  TextEditingController emailController = TextEditingController();


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
            Icon(Icons.lock_reset_outlined, size: 80, color: Colors.blue,),
        
        
            // REGISTER
            Text("Forget Password", style:TextStyle(fontSize: 25, fontWeight: FontWeight.bold) ,),
            Text("don't worry it happens",  style:TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold) ),


            SizedBox(height: 25,),
        
        
        
            // FORM (Name, email, password)
            Form(
              key: _formKey,
              child: Column(
                spacing: 15,
                children: [
        
                 
        
        
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
        

        
                ],
              ),
            ),






        
        
        
        
        
            // BUTTON
            SizedBox(
              height: 45,
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: (){

                  if (_formKey.currentState!.validate()) {

                    showLoading(context);

                    _authService
                    .forgetPw(emailController.text)
                    .then((value){
                      hideLoading(context);
                      showNotification("Success", "A password reset link has been sent to your email", context);
                    })
                    .catchError((error){
                      hideLoading(context);
                      showNotification("Failure", error , context, isError:  true);
                    })
                    ;


                    
                  }
              
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white), 
                label: Text("Reset Password"),
                icon: Icon(Icons.login),
              ),
            ),
        
        

          ],
        ),
      ),
    );
  }
}