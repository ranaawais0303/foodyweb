import 'package:flutter/material.dart';
import 'package:foodyweb/firebase_services.dart';

class OrderDataTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseServices _service = FirebaseServices();
    return StreamBuilder(
      stream:
          _service.Orders.orderBy('userEmail', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('some thing went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return DataTable(
          showBottomBorder: true,
          dataRowHeight: 60,
          headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
        );
      },
    );
  }
}
