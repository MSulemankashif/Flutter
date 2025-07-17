import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  
  ApiService apiService = ApiService();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  Widget build
  (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade700,
        title: Text("MyNotes"),
      ),

      floatingActionButton: FloatingActionButton(onPressed: 
      showFormDialoge(context)),
    )
  }
}