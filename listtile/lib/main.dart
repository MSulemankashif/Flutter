import 'package:flutter/material.dart';

void main() {
    List<Map> chatList = [
      {
        'name': "Suleman",
        'message': "Where are you?",
        'isSeen': true
      },
      {
        'name': "Ali",
        'message':  "Hello",
        'isSeen': false
      },
      {
        'name':"Usama",
        'message': "Learning List View",
        'isSeen' : true
      },
      {
        'name': "Dawood",
        'message': "Learning Flutter",
        'isSeen': false
      }
    ];

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 37, 141, 41),
          foregroundColor: Colors.white,
          title: Text('Whatsapp'),
          
        ),

        

        body:ListView.builder(
          itemCount: chatList.length,
          itemBuilder: (context, index)
          {
            return ListTile(
              title: Text(chatList[index]['name']),

              leading: CircleAvatar(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 53, 165, 55)
              ),

              subtitle: Row(
                children: [
                  Icon(Icons.done_all, color: chatList[index]['isSeen'] == true? Colors.blue : Colors.grey),
                  Text(chatList[index]['message'])
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('06:55 PM',),
                  Text('${chatList[index]['isSeen']? 'Seen' : 'Not Seen'}',
                    style: TextStyle(
                      color: chatList[index]['isSeen']? Colors.blue : Colors.grey
                    )
                  )
                ]
              )
              
            );
          },
        )
      ),
    )
  );
}

