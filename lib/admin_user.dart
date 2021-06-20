import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:foodyweb/sidebar.dart';

class Admin_user extends StatelessWidget {
  static const String id = 'Admin_user';
  @override
  Widget build(BuildContext context) {
    SideBarWidget _sidebar = SideBarWidget();
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('FOODY DASHBOARD'),
      ),
      sideBar: _sidebar.sidebarmenu(context, Admin_user.id),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: Text(
                'Admin user',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
