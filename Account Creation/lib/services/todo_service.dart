import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uuid/uuid.dart';


class TodoService {

  // instances
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore  _database = FirebaseFirestore.instance;



  // add 
  Future<void> addTodo(String title, desc)async{
    try {
      var uuid = Uuid();
      String todoId = uuid.v1();
      
      await _database
      .collection('users')
      .doc(_auth.currentUser!.uid)
      .collection('todos')
      .doc(todoId)
      .set({
        "id" : todoId,
        "title" : title,
        "desc" : desc,
        "createAt" : FieldValue.serverTimestamp()
      });
  
    } on FirebaseException catch (e) {
      throw e.message ?? "Something went wrong";
    }
  }



  // get
  Stream< List<Map<String, dynamic> >  > getTodos(){
    try {

      return _database
      .collection('users')
      .doc(_auth.currentUser!.uid)
      .collection("todos")
      .snapshots()
      .asyncMap((snapshot) {

        List<Map<String, dynamic> > todoList = [];

        for (var doc in snapshot.docs) {
          todoList.add(doc.data());
        }
        return todoList;
      },);

  
    } on FirebaseException catch (e) {
      throw e.message ?? "Something went wrong";
    }
  }



  // update



  // delete






}