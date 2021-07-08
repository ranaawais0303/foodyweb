import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:foodyweb/Emplooyee_Data/Employee.dart';
import 'package:foodyweb/Emplooyee_Data/employeeProvider.dart';
import 'package:foodyweb/Emplooyee_Data/myEmployeeList.dart';
import 'package:foodyweb/MyDining/MydiningOrder.dart';
import 'package:foodyweb/sidebar.dart';

class EmployeesScreen extends StatelessWidget {
  static const String id = 'EmployeeScreen';
  @override
  Widget build(BuildContext context) {
    SideBarWidget _sidebar = SideBarWidget();
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('FOODY DASHBOARD'),
      ),
      sideBar: _sidebar.sidebarmenu(context, EmployeesScreen.id),
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
                'Employees',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                ),
              ),
              // Text(
              //   'Add Employee',
              // ),
              Divider(
                thickness: 5,
              ),
              EmployeeCreate(),
              Divider(
                thickness: 5,
              ),
              MyEmployeeList(),
            ],
          ),
        ),
      ),
    );
  }
}
