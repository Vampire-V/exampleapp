import 'package:exampleapp/screens/home.dart';
import 'package:flutter/material.dart'; //import เพื่อสร้างหน้าจอบนมือถือ

//constructor void type
void main() {
  //เมื่อ constructor ทำงาน จะเอา object MyApp มาทำงาน
  runApp(MyApp());
}

// stf เอาไว้สร้าง stl อีกทอดหนึ่ง
// stl จะสร้าง StatelessWidget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return Object MaterialApp ที่เรา import มา
    return MaterialApp(
      // Home() import มาจาก home.dart
      home: Home(),
    );
  }
}
