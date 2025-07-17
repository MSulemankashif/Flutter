import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});


  ApiService apiService = ApiService();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade700,
        title: Text("My Notes"),
      ),

      floatingActionButton: FloatingActionButton(onPressed: (){
        showFormDialoge(context);
      },
      foregroundColor: Colors.black,
      backgroundColor: Colors.amber.shade700,
      child: Icon(Icons.add),
      ),
    );
  }

  showFormDialoge(BuildContext context){

    showDialog(
    context: context, 
    builder: (context){
      return AlertDialog(
        title: Text("Add Notes"),
        content: Column(
          mainAxisAlignment: MainAxisSize.min,
          children: [

            // title
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Enter Title",
                border: OutlineInputBorder()
              ),
            ),

          SizedBox(height: 6,),

          // Desc 
          TextField(
            controller: descController,
            // TBC
          )

          ],
        ),
      )
    });
  }




}