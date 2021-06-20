import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:foodyweb/sidebar.dart';

class Deshboard extends StatelessWidget {
  static const String id = 'Deshboard';
  final Future<FirebaseApp> initialization = Firebase.initializeApp();
  //String user_email = MyProvider().getUserMail();
  Widget drawerItem({@required String name, @required IconData icon}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        name,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SideBarWidget _sidebar = SideBarWidget();
    return AdminScaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text('FOODY DASHBOARD'),
        ),
        sideBar: _sidebar.sidebarmenu(context, Deshboard.id),
        body: Center(
            child: Container(
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/hotel.jpg"),
                        fit: BoxFit.cover)),
                child: Center(
                  child: Text(
                    'Foody we are providing you the best taste',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.brown,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ))));
  }
}
