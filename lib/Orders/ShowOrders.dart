import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:foodyweb/Orders/MyOrder.dart';
import 'package:foodyweb/sidebar.dart';

class OrderScreen extends StatelessWidget {
  static const String id = 'Orders';
  @override
  Widget build(BuildContext context) {
    SideBarWidget _sidebar = SideBarWidget();
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('FOODY DASHBOARD'),
      ),
      sideBar: _sidebar.sidebarmenu(context, OrderScreen.id),
      body: SingleChildScrollView(
        child: Container(
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
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  'Orders',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 36,
                  ),
                ),
                Text('Online orders'),
                Divider(thickness: 5),
                MyOrders(),
              ],
            )),
      ),
    );
  }
}
