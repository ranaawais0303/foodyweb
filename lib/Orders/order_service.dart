import 'package:cloud_firestore/cloud_firestore.dart';

class OrderServices {
  CollectionReference orders =
      FirebaseFirestore.instance.collection('onlineOrder');
  Future<void> updateOrderStatus(documentId, status) {
    var result = orders.doc(documentId).update({'orderStatus': status});
    return result;
  }
  // Future<DocumentReference> saveOrder(Map<String, dynamic> data) {
  //   var result = orders.add(data);
  //   return result;
  // }
}
