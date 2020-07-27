import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:setTehma(),
      home: MyHomePage(),
    );
  }
}

setTehma(){
return  ThemeData(
    primaryColor: const Color(0xff7FA4F5),
    accentColor: const Color(0xff5E5E5E),  
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      ),
    ),                      
  );
}