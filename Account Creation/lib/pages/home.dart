import 'package:firebase_app/helper/helper_function.dart';
import 'package:firebase_app/pages/add_todo.dart';
import 'package:firebase_app/pages/login.dart';
import 'package:firebase_app/pages/profile.dart';
import 'package:firebase_app/services/auth_service.dart';
import 'package:firebase_app/services/todo_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  TodoService _todoService = TodoService();
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    TodoService().getTodos();
    return Scaffold(

      appBar: AppBar(
        title: Text("Home"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: () {
                    gotoPage(ProfilePage(), context);
                  },
                  child: Text("Profile")
                ),
                PopupMenuItem(
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
                  child: Text("Logout")
                )
              ];
            },
          )
        ],
      ),


      body: StreamBuilder(
        stream: _todoService.getTodos(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),);
          }
          else if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()),);
          }
          else if(snapshot.data!.isEmpty){
            return Center(child: Text("No Todos Found"),);
          }
          else{

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var data = snapshot.data![index];

                return Card(
                  color: Colors.blue.shade200,
                  child: ListTile(
                    title: Text(data['title']),
                    subtitle: Text(data['desc']),
                  ),
                );
              },
            );


          }
        },
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          gotoPage(AddTodoPage(), context);
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
        child: Icon(Icons.note_add),
      ),




    );
  }
}