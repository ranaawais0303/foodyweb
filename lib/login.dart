import 'package:ars_dialog/ars_dialog.dart';
import 'package:flutter/material.dart';
import 'package:foodyweb/Deshboard.dart';
import 'package:foodyweb/firebase_services.dart';

class Login extends StatefulWidget {
  static const String id = 'Login';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseServices _services = FirebaseServices();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ProgressDialog _progressDialog = ProgressDialog(
      context,
      blur: 2,
      backgroundColor: Color(0xFF84c225).withOpacity(.3),
      transitionDuration: Duration(microseconds: 500),
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.teal,
        title: Text(
          'Foody Admin pannel',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        // title: ,
        // theme: ThemeData(
        //   primarySwatch: Colors.teal,
        // ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.teal,
              Colors.white,
            ],
            stops: [0.5, 0.0],
            begin: Alignment.topCenter,
            end: Alignment(0.0, 0.0),
          ),
        ),
        child: Center(
          child: Container(
            height: 400,
            width: 300,
            child: Card(
              elevation: 6,
              shape: Border.all(color: Colors.teal, width: 2.0),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Image.asset(
                              'images/logo.png',
                              height: 100,
                              width: 100,
                            ),
                            Text(
                              'Foody',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 20),
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'enter username';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  labelText: 'username',
                                  icon: Icon(Icons.person),
                                  hintText: 'user name',
                                  contentPadding:
                                      EdgeInsets.only(left: 20, right: 20),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                          width: 2))),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'enter password ';
                                }
                                if (value.length < 6) {
                                  return 'mininmum length is 6 chractors';
                                }
                                return null;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                  helperText: 'minimum 6 charactors',
                                  labelText: 'password',
                                  icon: Icon(Icons.vpn_key_rounded),
                                  hintText: 'Password',
                                  contentPadding:
                                      EdgeInsets.only(left: 20, right: 20),
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                          width: 2))),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                _progressDialog.show();
                                if (formkey.currentState.validate()) {
                                  _services.getAdminCredentials().then((value) {
                                    value.docs.forEach((doc) {
                                      if (doc.get('username') == 'Admin@1122') {
                                        if (doc.get('password') == '123456') {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext) =>
                                                      Deshboard()));
                                        } else {
                                          _services.showMyDialog(
                                              title: 'invalid Password',
                                              message: 'Enter valid Password',
                                              context: context);
                                        }
                                      } else {
                                        _services.showMyDialog(
                                            title: 'invalid username',
                                            message: 'Enter valid username',
                                            context: context);
                                      }
                                    });
                                  });
                                }
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.teal),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
