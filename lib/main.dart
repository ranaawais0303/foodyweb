import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodyweb/Deshboard.dart';
import 'package:foodyweb/Emplooyee_Data/employeeProvider.dart';
import 'package:foodyweb/MyDining/MyDiningProvider.dart';
import 'package:foodyweb/Orders/MyOrder.dart';
import 'package:foodyweb/Orders/ShowOrders.dart';
import 'package:foodyweb/Orders/order_provider.dart';
import 'package:foodyweb/admin_user.dart';
import 'package:foodyweb/banner-screen.dart';
import 'package:foodyweb/login.dart';
import 'MyDining/Dining.dart';
import 'Emplooyee_Data/employeeScreen.dart';
import 'package:foodyweb/widget/category-Widget/my_category.dart';
import 'package:provider/provider.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(Foody());
}

class Foody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => (OrderProvider())),
        ChangeNotifierProvider(create: (_) => (MyDiningProvider())),
        ChangeNotifierProvider(create: (_) => (MyEmployeeProvider())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Login(),
        initialRoute: Login.id,
        routes: {
          CategoryScreen.id: (context) => CategoryScreen(),
          OrderScreen.id: (context) => OrderScreen(),
          Deshboard.id: (context) => Deshboard(),
          Login.id: (context) => Login(),
          //MyOrders.id: (context) => MyOrders(),
          DiningScreen.id: (context) => DiningScreen(),
          Admin_user.id: (context) => Admin_user(),
          EmployeesScreen.id: (context) => EmployeesScreen(),
          BannerScreen.id: (context) => BannerScreen(),
        },
      ),
    );
  }
}
