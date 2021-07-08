import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:foodyweb/Deshboard.dart';
import 'package:foodyweb/Orders/MyOrder.dart';
import 'package:foodyweb/Orders/ShowOrders.dart';
import 'package:foodyweb/admin_user.dart';
import 'package:foodyweb/banner-screen.dart';
import 'package:foodyweb/login.dart';
import 'MyDining/Dining.dart';
import 'Emplooyee_Data/employeeScreen.dart';
import 'package:foodyweb/widget/category-Widget/my_category.dart';

class SideBarWidget {
  sidebarmenu(context, selectedRoute) {
    return SideBar(
        activeBackgroundColor: Colors.black54,
        activeIconColor: Colors.white,
        activeTextStyle: TextStyle(color: Colors.white),
        //backgroundColor: Colors.black45,
        items: const [
          MenuItem(
            title: 'Dashboard',
            route: Deshboard.id,
            icon: Icons.dashboard,
          ),

          MenuItem(
            title: 'Category',
            route: CategoryScreen.id,
            icon: Icons.category,
          ),
          // MenuItem(
          //   title: 'Admin Users',
          //   route: Admin_user.id,
          //   icon: Icons.person_rounded,
          // ),
          MenuItem(
            title: 'Online Orders',
            route: OrderScreen.id,
            icon: CupertinoIcons.cart_fill,
          ),
          MenuItem(
            title: 'Dining',
            route: DiningScreen.id,
            icon: Icons.notifications,
          ),
          MenuItem(
            title: 'Employees',
            route: EmployeesScreen.id,
            icon: Icons.person_rounded,
          ),
          MenuItem(
            title: 'Exit',
            route: Login.id,
            icon: Icons.exit_to_app,
          ),
          // MenuItem(
          //   title: 'Dining Orders',
          //   route: OrderDScreen.id,
          //   icon: CupertinoIcons.cart_fill,
          // ),
          // MenuItem(
          //   title: 'Exit',
          //   route: '/',
          //   icon: Icons.exit_to_app,
          // ),
        ],
        selectedRoute: selectedRoute,
        onSelected: (item) {
          Navigator.of(context).pushNamed(item.route);
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: Colors.black26,
          child: Center(
            child: Text(
              'MENU',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold
                  // letterSpacing: 2,
                  ),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: Colors.black26,
          child: Center(
            child: Image.asset(
              'images/logo1.png',
              height: 30,
            ),
          ),
        ));
  }
}
