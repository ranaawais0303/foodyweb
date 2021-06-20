import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EmployeeService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference Employee =
      FirebaseFirestore.instance.collection('Employee');
  Future<void> updateEmployeeStatus(documentId, status) {
    var data = Employee.doc(documentId).update({'status': status});
    return data;
  }

  ///////////////////////////////////////////////////////////////////////////
///////////Employee Add//////////////////////////////////
  Future<bool> addEmployeeTodb(
      name, empNo, salary, status, attCount, id, wadges) async {
    int sal = int.parse(salary);
    int attC = int.parse(attCount);
    int ids = int.parse(id);
    int wag = int.parse(wadges);
    try {
      Employee.doc().set({
        'EmpName': name,
        'EmpNo': empNo,
        'Salary': sal,
        'status': status,
        'attendencecount': attC,
        'id': ids,
        'wadges': wag,
      });
      return true;
    } catch (e) {
      print('error uploading Employee: ' + e.toString());
      return false;
    }
  }

  Future<void> showEmployeeDialog({title, message, context}) async {
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

  ///////////////////////delete category image////////////////
  Future<String> deleteEmployeeTodb(id) async {
    db.collection('Employee').doc(id).delete();
  }

  Future<void> ConfirmEmployeeDeleteDialog(
      {title, message, context, id}) async {
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
                  deleteEmployeeTodb(id);
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
}
