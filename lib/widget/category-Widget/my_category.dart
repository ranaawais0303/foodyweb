import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:foodyweb/firebase_services.dart';
import 'package:foodyweb/sidebar.dart';
import 'package:foodyweb/widget/category-Widget/category_list_widget.dart';
import 'package:foodyweb/widget/category-Widget/category_upload.dart';
//rana we will make a change
class CategoryScreen extends StatefulWidget {
  static const String id = 'Category';
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  SideBarWidget _sidebar = SideBarWidget();
  FirebaseServices _services = FirebaseServices();
  var fileNameTextController = TextEditingController();
  bool _visible = false;
  bool imageSelected = true;
  String _url;
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('FOODY DASHBOARD'),
      ),
      sideBar: _sidebar.sidebarmenu(context, CategoryScreen.id),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category screen',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 36,
                    ),
                  ),
                  Text('add new cateogories'),
                  Divider(thickness: 5),
                  CategoryCreateWidget(),
                  Divider(thickness: 5),
                  CategoryListWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
