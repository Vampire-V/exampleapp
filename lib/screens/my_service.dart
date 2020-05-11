import 'package:exampleapp/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Explicit
  // Method
  Widget signOutButton() {
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      tooltip: 'Sign Out',
      onPressed: () {
        myAlert();
      },
    );
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure ?'),
            content: Text('Do you want sign out ?'),
            actions: <Widget>[cancelButton(), okButton()],
          );
        });
  }

  Widget okButton() {
    return FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
          processSignOut();
        },
        child: Text('OK'));
  }
  Future <void> processSignOut()async{
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signOut().then((reponse) {
      MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext context) => Home());
      Navigator.of(context).pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false);
    });
  }
  Widget cancelButton() {
    return FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('Cancel'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade200,
        title: Text(
          'My-Service',
        ),
        actions: <Widget>[signOutButton()],
      ),
      body: Text("Service"),
    );
  }
}
