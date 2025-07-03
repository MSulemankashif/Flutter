import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context){
    return  MaterialApp(
      initialRoute: "",
      routes: {
        "": (context) => HomeScreen(),
        "about": (context) => AboutScreen()
      }
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: TextButton(onPressed:(){
          Navigator.of(context).pushNamed("about");
        }, child: Text("Go to About Page"),
        )
      )
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Page"),
      ),
      body: Center(
        child: TextButton(onPressed:(){
          Navigator.of(context).pushNamed("");
        }, child: Text("Go to Home Page"),
        )
      )
    );
  }
}