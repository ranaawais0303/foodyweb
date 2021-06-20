import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseServices {
  Future<QuerySnapshot> getAdminCredentials() {
    var result = FirebaseFirestore.instance.collection('Admin').get();
    return result;
  }

  final db = FirebaseFirestore.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference category_r =
      FirebaseFirestore.instance.collection('category');
  CollectionReference Orders =
      FirebaseFirestore.instance.collection('onlineOrder');
  FirebaseStorage storage = FirebaseStorage.instance;

  ///////////////////////////////////////////////////////////////////////////
  ///////////Category upload//////////////////////////////////
  Future<bool> UploadCategoryImageTodb(
      downloadUrl, catName, catPrice, catComPrice, catDescription) async {
    int catP = int.parse(catPrice);
    int catC = int.parse(catComPrice);
    try {
      if (downloadUrl != null) {
        category_r.doc().set({
          'image': downloadUrl,
          'name': catName,
          'price': catP,
          'comparedPrice': catC,
          'description': catDescription,
        });
        return true;
      }
    } catch (e) {
      print('error uploading category: ' + e.toString());
      return false;
    }
  }

///////////////////////delete category image////////////////
  Future<String> deleteCategoryImageTodb(id) async {
    firestore.collection('category').doc(id).delete();
  }

  Future<void> ConfirmDeleteDialog({title, message, context, id}) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(message),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  deleteCategoryImageTodb(id);
                },
                child: Text('Delete'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
            ],
          );
        });
  }

  Future<void> showMyDialog({title, message, context}) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(message),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok'),
              ),
            ],
          );
        });
  }
}
