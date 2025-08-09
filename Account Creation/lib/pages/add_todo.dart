
import 'package:firebase_app/helper/helper_function.dart';
import 'package:firebase_app/services/auth_service.dart';
import 'package:firebase_app/services/todo_service.dart';
import 'package:flutter/material.dart';

class AddTodoPage extends StatelessWidget {

  AddTodoPage({super.key});

  
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TodoService _service = TodoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 15,
          children: [
            
        
        
            // REGISTER
            Text("Create Todo", style:TextStyle(fontSize: 25, fontWeight: FontWeight.bold) ,),
            Text("add title and description",  style:TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold) ),


            SizedBox(height: 25,),
        
        
        
            // FORM (Name, email, password)
            Form(
              key: _formKey,
              child: Column(
                spacing: 15,
                children: [
        
                 
        
        
                  // title fields
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100)
                      ),
                      hintText: "Enter Title",
                      fillColor: Colors.grey.shade400,
                      filled: true,
                    ),
                    validator: (input){
                      if (input!.isEmpty) {
                        return "Title is required";
                      }

                    },
                  ),
        
        
        
                  // desc fields
                  TextFormField(
                    maxLines: 4,
                    controller: descController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      hintText: "Enter Description",
                      fillColor: Colors.grey.shade400,
                      filled: true,
                    ),
                    validator: (input){
                      if (input!.isEmpty) {
                        return "Description is required";
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
                    _service
                    .addTodo(titleController.text, descController.text)
                    .then((value){
                      hideLoading(context);
                      showNotification("Success", "Todo added successfully", context);
                      Navigator.pop(context);
                    })
                    .catchError((error){
                      hideLoading(context);
                      showNotification("Failed", error, context, isError: true);
                    });
                  }
              
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white), 
                label: Text("Add Todo"),
                icon: Icon(Icons.note_add_outlined),
              ),
            ),
        

          ],
        ),
      ),
    );
  }
}