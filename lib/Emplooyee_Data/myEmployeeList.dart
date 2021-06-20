import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:foodyweb/Emplooyee_Data/Employee_Service.dart';
import 'package:foodyweb/Emplooyee_Data/employeeProvider.dart';
import 'package:provider/provider.dart';

class MyEmployeeList extends StatefulWidget {
  static const String id = 'Orders';
  @override
  _MyEmployeeListState createState() => _MyEmployeeListState();
}

class _MyEmployeeListState extends State<MyEmployeeList> {
  double sal;
  double wag;
  double attend;
  ScrollController _controller;
  EmployeeService _employeeService = EmployeeService();
  // MyDiningServices _myDiningServices = MyDiningServices();
//  User user = FirebaseAuth.instance.currentUser;
  int tag = 1;
  List<String> options = [
    'All Orders',
    'Ordered',
    'Accepted',
    'Picked Up',
    'On the way',
    'Delivered',
  ];
  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var myEmployeeProvider = Provider.of<MyEmployeeProvider>(context);
    // var _myDiningProvider = Provider.of<MyDiningProvider>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          child: StreamBuilder<QuerySnapshot>(
            stream: _employeeService.Employee
                //_myDiningServices.myDining
                // .where('userId', isEqualTo: user.uid)
                // .where('status',
                //     isEqualTo: tag > 0 ? myEmployeeProvider.status : null)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.data.size == 0) {
                //TODO no order screen
                return Center(
                  child: Text(tag > 0
                      ? 'No ${options[tag]} orders'
                      : 'No Orders. Continue Shopping'),
                );
              }

              return Expanded(
                child: ListView(
                  controller: _controller,
                  scrollDirection: Axis.vertical,
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    var Salary = 300;
                    // double Salary = (document.data()['wadges'] *
                    //     document.data()['attendencecount']);
                    return Material(
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              horizontalTitleGap: 0,
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 14,
                                child: Icon(
                                  CupertinoIcons.square_list,
                                  size: 18,
                                  color: document.data()['status'] == 'Absent'
                                      ? Colors.red
                                      : document.data()['status'] == 'Present'
                                          ? Colors.blueGrey
                                          : Colors.orangeAccent,
                                ),
                              ),
                              title: Text(
                                document.data()['status'],
                                style: TextStyle(
                                    fontSize: 12,
                                    color: document.data()['status'] == 'Absent'
                                        ? Colors.red
                                        : document.data()['status'] == 'Present'
                                            ? Colors.blueGrey
                                            : Colors.orangeAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                              // subtitle: Text(
                              //   'On ${DateFormat.yMMMd().format(
                              //     DateTime.parse(document.data()['timestamp']),
                              //   )}',
                              //   style: TextStyle(fontSize: 12),
                              // ),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Employee : ${document.data()['EmpName']}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Employee id :  ${document.data()['id']}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            ExpansionTile(
                              title: Text(
                                ' details',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black),
                              ),
                              subtitle: Text(
                                'View o details',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              children: [
                                Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        //radius: 20,
                                        backgroundColor: Colors.white,
                                        child: Text(
                                          'W:${document.data()['wadges'].toString()}',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w100,
                                          ),
                                        ),
                                      ),
                                      // title: Text(
                                      //   'Salary: ${document.data()[Salary].toString()}',
                                      //   style: TextStyle(fontSize: 13),
                                      // ),
                                    ),
                                    // subtitle: Text(
                                    //   '${document.data()['products']} x PKR ${document.data()['products'][index]['productPrice'].toString()}',
                                    //   style: TextStyle(
                                    //       color: Colors.grey,
                                    //       fontSize: 12),
                                    // ),
                                    // ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12, top: 8, bottom: 8),
                                  child: Card(
                                    //color: Colors.grey[200],
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Salary : ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13),
                                              ),
                                              Text(
                                                document
                                                    .data()['Salary']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 13),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Divider(
                              height: 3,
                              color: Colors.grey,
                            ),
                            document.data()['status'] == 'Present'
                                ? Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          40, 8, 40, 8),
                                      child: TextButton(
                                        onPressed: () {
                                          showDialog('checkout', 'start',
                                              document.id, context);
                                          _employeeService.Employee.doc(
                                                  document.id)
                                              .update({
                                            'attendencecount':
                                                FieldValue.increment(1),
                                            'Salary':
                                                document.data()['wadges'] *
                                                    (document.data()[
                                                            'attendencecount'] +
                                                        1)
                                          });
                                        },
                                        child: Text(
                                          'checkOut',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.orange),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    color: Colors.grey,
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextButton(
                                              onPressed: () {
                                                showDialog(
                                                    'Present employee',
                                                    'Present',
                                                    document.id,
                                                    context);
                                              },
                                              child: Text(
                                                'Present',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.blueGrey),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: AbsorbPointer(
                                              absorbing:
                                                  document.data()['status'] ==
                                                          'Absent'
                                                      ? true
                                                      : false,
                                              child: TextButton(
                                                onPressed: () {
                                                  showDialog(
                                                      'Absent',
                                                      'Absent ',
                                                      document.id,
                                                      context);
                                                },
                                                child: Text(
                                                  'Absent',
                                                  style: TextStyle(
                                                      color: document.data()[
                                                                  'Absent Employee'] ==
                                                              'Absent'
                                                          ? Colors.grey
                                                          : Colors.red),
                                                ),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Colors.blueGrey),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            Divider(
                              height: 3,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  showDialog(title, status, documentId, context) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text('are u sure??'),
            actions: [
              TextButton(
                onPressed: () {
                  EasyLoading.show(status: 'updating Status');
                  status == 'Present'
                      ? _employeeService
                          .updateEmployeeStatus(documentId, status)
                          .then((value) {
                          EasyLoading.showSuccess('updated successfully');
                        })
                      : _employeeService
                          .updateEmployeeStatus(documentId, status)
                          .then((value) {
                          EasyLoading.showSuccess('updated successfully');
                        });

                  Navigator.pop(context);
                },
                child: Text(
                  'ok',
                  style: TextStyle(color: Colors.blueGrey),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'cancel',
                  style: TextStyle(color: Colors.red),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor),
                ),
              ),
            ],
          );
        });
  }
}
