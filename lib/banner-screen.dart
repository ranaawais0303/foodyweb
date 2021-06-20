import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:foodyweb/sidebar.dart';

class BannerScreen extends StatelessWidget {
  static const String id = 'BannerScreen';
  @override
  Widget build(BuildContext context) {
    SideBarWidget _sidebar = SideBarWidget();
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('FOODY DASHBOARD'),
      ),
      sideBar: _sidebar.sidebarmenu(context, BannerScreen.id),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Banner screen',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 36,
                    ),
                  ),
                  Text(
                    'Add/Delete Home screen banner images',
                  ),
                  Divider(thickness: 5),
                  //
                  Divider(thickness: 5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
