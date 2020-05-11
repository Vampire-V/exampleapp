import 'package:exampleapp/screens/authen.dart';
import 'package:exampleapp/screens/my_service.dart';
import 'package:exampleapp/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// StatefulWidget ต้องตั้งชื่อให้สัมพันธ์กัน
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  // Method
  // checkStatus การ  login
  Future<void> checkStatus() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    print(firebaseUser);
    if (firebaseUser != null) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    }
  }

  // สร้าง function return เป็น Widget
  Widget showLogo() {
    // สร้าง Floder image เก็บภาพ แล้วไปแก้ไฟล์ pubspec.yaml เปิดใช้งาน assets กับไฟล์ภาพ
    // Image asset ใช้ภาพที่อยู่ในแพ Image file ดึงรูปจากไฟล์ Image network ดึงรูปจาก internet
    // ใส่ Container ครอบเพื่อปรับ size image
    return Container(
      width: 120.0,
      height: 120.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showAppName() {
    // fontFamily สร้าง Floder fonts เก็บ ไฟล์ .ttf เอามาแค่ไฟล์ Regular แล้วไปเปิดใช้งานเหมือนกับ images
    return Text(
      'ชื่อแอพ',
      style: TextStyle(
        fontSize: 40.0,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        fontFamily: 'Srisakdi',
      ),
    );
  }

  Widget signInButton() {
    return RaisedButton(
      child: Text('Sign In'),
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(18.0),
        side: BorderSide(
          color: Colors.red,
        ),
      ),
      onPressed: () {
        MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext context) => Authen());
        Navigator.of(context).push(materialPageRoute);
      },
      color: Colors.red,
      textColor: Colors.white,
    );
  }

  Widget signUpButton() {
    return RaisedButton(
      child: Text('Sign Up'),
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.blue.shade700)),
      onPressed: () {
        print('Click Sign Up!');
        // การทำ Route
        // จะเหมือนกันกับ Class obj = new Class
        // new Class สั่ง Object Register ให้ทำงาน เพื่อสร้าง Stateless และโยนกลับ ผ่าน BuildContext มาที่ main.dart
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Register());
        // Navigator การใช้ Push จะสร้าง Arrow back กลับมาหน้าเดิมให้ด้วย
        Navigator.of(context).push(materialPageRoute);
      },
      color: Colors.blue.shade700,
      textColor: Colors.white,
    );
  }

  Widget showButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        signInButton(),
        SizedBox(
          width: 4.0,
        ),
        signUpButton(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold คือ คลาสที่มี Theme พวก appbar body ....
    return Scaffold(
      body: SafeArea(
        // SafeArea จะทำให้หน้าจอแอพที่เราสร้างไม่ซ้อนทัพกับ navigation มือถือ
        child: Container(
          decoration: BoxDecoration(
            // ใส่สีพื้นหลัง และ ไล่สี
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blue,
                  Colors.red.shade200,
                ]),
          ),
          child: Center(
            //center เป็นการจัด Widget ให้อยู่ตรงกลางของแกน X แต่ MainAxisSize Default คือ Max จะอยู่บนสุดแกน Y
            // Column จะเรียงจากบนลงล่าง
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                showLogo(),
                showAppName(),
                showButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
