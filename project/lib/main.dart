import 'package:flutter/material.dart';

void main(){
    runApp(
        MaterialApp(
            debugShowCheckedModeBanner: false,

            home: Scaffold(
                backgroundColor: const Color.fromARGB(255, 207, 206, 209),

                appBar: AppBar(
                    backgroundColor: const Color.fromARGB(255, 20, 112, 187),
                    title: Icon(Icons.facebook, size:50, color:Colors.white,),
                ),
                
                body: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                        Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextField(
                                enabled: true,
                                controller: TextEditingController(text: "Dummy Text"),
                            ),
                        ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:[
                            CircleAvatar(radius: 30, backgroundColor: Colors.green, child: Text("1"),),
                            CircleAvatar(radius: 30, backgroundColor: Colors.green, child: Text("2"),),
                            CircleAvatar(radius: 30, backgroundColor: Colors.green, child: Text("3"),),
                        ],
                    ),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:[
                            CircleAvatar(radius: 30, backgroundColor: Colors.green, child: Text("4"),),
                            CircleAvatar(radius: 30, backgroundColor: Colors.green, child: Text("5"),),
                            CircleAvatar(radius: 30, backgroundColor: Colors.green, child: Text("6"),),
                        ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:[
                            CircleAvatar(radius: 30, backgroundColor: Colors.green, child: Text("7"),),
                            CircleAvatar(radius: 30, backgroundColor: Colors.green, child: Text("8"),),
                            CircleAvatar(radius: 30, backgroundColor: Colors.green, child: Text("9"),),
                        ],
                    ),  

                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:[
                            CircleAvatar(radius: 30, backgroundColor: Colors.green, child: Text("0"),),
                        ],
                    ), 
                    
                ],)
            )
        )
    );
}