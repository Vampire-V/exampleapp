import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // method
  Widget backButton() {
    return IconButton(
        icon: Icon(Icons.navigate_before),
        onPressed: () {
          Navigator.of(context).pop();
        });
  }

  Widget conten() {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          showAppName(),
        ],
      ),
    );
  }

  Widget showAppName() {
    return Row(mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        showLogo(),
        showText(),
      ],
    );
  }

  Widget showLogo() {
    return Container(
      width: 48.0,
      height: 48.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showText() {
    return Text('ชื่อแอพ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            backButton(),
            conten(),
          ],
        ),
      ),
    );
  }
}
