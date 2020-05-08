import 'package:exampleapp/screens/my_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Explicit
  // formKey สร้างมาเก็บ input โดยไปสร้าง Widget Form คลุม View ของ input ที่ต้องการ และใส่ key : formKey จึงจะดึง value ใน input มาได้
  final formKey = GlobalKey<FormState>();
  String nameString, emailString, passwordString;
  // Initially password is obscure
  bool _obscureText = true;

  // Method
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget showIcon() {
    return Container(
      width: 120.0,
      height: 120.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget registerButton() {
    return RaisedButton(
      child: Text('Register'),
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(18.0),
        side: BorderSide(
          color: Colors.blue,
        ),
      ),
      onPressed: () {
        // check validate ของ input ทั้งหมด
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          registerTreade();
        }
      },
      color: Colors.blue,
      textColor: Colors.white,
    );
  }

  // Treade type void : Treade คือ function app asynchronous เหมือน Promise ของ javascript
  Future<void> registerTreade() async {
    // Call method firebase
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .createUserWithEmailAndPassword(
      email: emailString,
      password: passwordString,
    )
        .then((response) {
      setupDisplayName();
    }).catchError((response) {
      String title = response.code;
      String message = response.message;
      alertMessage(title, message);
    });
  }

  Future<void> setupDisplayName() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.currentUser().then((response) {
      UserUpdateInfo userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = nameString;
      response.updateProfile(userUpdateInfo);

      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    });
  }

  void alertMessage(String title, String message) {
    // สามารถดึง showDialog มาใช้ได้เพราะ Class extends State ใน State มี method ให้ใช้
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: ListTile(
              leading: Icon(
                Icons.add_alert,
                color: Colors.red,
                size: 48.0,
              ),
              title: Text(
                title,
                style: TextStyle(color: Colors.red),
              ),
            ),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  Widget nameText() {
    return TextFormField(
      // InputDecoration จะมี Property ให้ใช้ เช่น icon style label
      decoration: InputDecoration(
        icon: Icon(Icons.face),
        labelText: 'Display Name',
        // helperText: 'Type you name',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please Fill Your Name Blank';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        nameString = value.trim();
      },
    );
  }

  Widget emailText() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      // InputDecoration จะมี Property ให้ใช้ เช่น icon style label
      decoration: InputDecoration(
        icon: Icon(Icons.email),
        labelText: 'Display Email',
        // helperText: 'Type you name',
      ),
      validator: (String value) {
        if (!((value.contains('@')) && (value.contains('.')))) {
          return 'Please type email';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        emailString = value.trim();
      },
    );
  }

  Widget passwordText() {
    return TextFormField(
      // InputDecoration จะมี Property ให้ใช้ เช่น icon style label
      // obscureText คือ จะแสดงรหัสผ่านไหม Default = false
      decoration: InputDecoration(
        icon: Icon(Icons.lock),
        labelText: 'Display Password',

        // helperText: 'Type you name',
      ),
      validator: (String value) {
        if (value.length < 6) {
          return 'Password more 6 charactor';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        passwordString = value.trim();
      },
      obscureText: _obscureText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red.shade200,
          title: Text('Register'),
          actions: <Widget>[
            showIcon(),
          ],
        ),
        body: Form(
          key: formKey,
          child: ListView(
            // ListView เหมือน Column แต่อันนี้จะ scoll ได้
            padding: EdgeInsets.all(30.0),
            children: <Widget>[
              nameText(),
              emailText(),
              passwordText(),
              new FlatButton(
                  onPressed: _toggle,
                  child: new Text(
                      _obscureText ? "Show Password" : "Hide Password")),
              SizedBox(
                height: 12.0,
              ),
              registerButton(),
            ],
          ),
        ));
  }
}
