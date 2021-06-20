import 'package:flutter/cupertino.dart';

class MyEmployeeProvider with ChangeNotifier {
  String status;

  filterOrder(status) {
    this.status = status;
    notifyListeners();
  }
}
