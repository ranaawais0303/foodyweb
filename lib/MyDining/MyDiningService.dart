import 'package:cloud_firestore/cloud_firestore.dart';

class MyDiningServices {
  CollectionReference myDining =
      FirebaseFirestore.instance.collection('diningOrder');
  Future<void> updateMyDiningStatus(documentId, status) {
    var data = myDining.doc(documentId).update({'orderStatus': status});
    return data;
  }
// Future<DocumentReference> saveOrder(Map<String, dynamic> data) {
//   var result = orders.add(data);
//   return result;
// }
}
