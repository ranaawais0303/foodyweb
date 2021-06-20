import 'package:flutter/cupertino.dart';

class MyDiningProvider with ChangeNotifier {
  String status;

  filterOrder(status) {
    this.status = status;
    notifyListeners();
  }
}
