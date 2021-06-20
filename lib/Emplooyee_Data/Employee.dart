import 'package:ars_dialog/ars_dialog.dart';
import 'package:flutter/material.dart';
import 'package:foodyweb/Emplooyee_Data/Employee_Service.dart';
import 'package:foodyweb/constant/const.dart';
import 'package:foodyweb/firebase_services.dart';

class EmployeeCreate extends StatefulWidget {
  @override
  _EmployeeUploadState createState() => _EmployeeUploadState();
}

class _EmployeeUploadState extends State<EmployeeCreate> {
  final _formKey = GlobalKey<FormState>();
  EmployeeService Employee = EmployeeService();
  var empName = TextEditingController();
  var empNo = TextEditingController();
  var salary = TextEditingController();
  var status = TextEditingController();
  var attCount = TextEditingController();
  var id = TextEditingController();
  var wadges = TextEditingController();

  bool _visible = false;
  // Reference _url;
  DateTime datetime = DateTime.now();
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    status.text = 'start';
    ProgressDialog _progressDialog = ProgressDialog(
      context,
      blur: 2,
      backgroundColor: Color(0xFF84c225).withOpacity(.3),
      transitionDuration: Duration(microseconds: 500),
    );
    return Container(
      color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Row(children: [
          Visibility(
            visible: _visible,
            child: Container(
              //height: 300,
              child: Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 200,
                                height: 30,
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  controller: empName,
                                  validator: (String value) {
                                    empName.text = value;
                                    if (value.isEmpty) {
                                      return 'Please Enter an Employee';
                                    }
                                    if (!RegExp(
                                            r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$")
                                        .hasMatch(value)) {
                                      return 'Please enter a valid Employee';
                                    }
                                    return null;
                                  },
                                  decoration: buildInputDecoration(
                                      Icons.person, "Employee"),
                                  // controller: empName,
                                  // decoration: InputDecoration(
                                  //   focusedBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(
                                  //         color: Colors.black, width: 1),
                                  //   ),
                                  //   filled: true,
                                  //   fillColor: Colors.white,
                                  //   hintText: ('Enter Employee name '),
                                  //   validator: (empName) {
                                  //     if (empName == null || empName.isEmpty) {
                                  //       return 'Text is empty';
                                  //     }
                                  //     return null;
                                  //   },
                                  //   border: OutlineInputBorder(),
                                  //   contentPadding: EdgeInsets.only(left: 20),
                                  //   // errorText: _validate
                                  //   //     ? 'Value Can\'t Be Empty'
                                  //   //     : null,
                                  // ),
                                ),
                              ),
                              SizedBox(
                                  width: 200,
                                  height: 30,
                                  child: TextFormField(
                                    // autofillHints: [
                                    //   AutofillHints.telephoneNumber
                                    // ],
                                    textAlign: TextAlign.center,
                                    controller: empNo,
                                    validator: (String value) {
                                      // empNo.text = value;
                                      if (value.isEmpty) {
                                        return 'Please Employee number';
                                      }
                                      if (!RegExp(r"^\+?0[0-9]{10}$")
                                          .hasMatch(value)) {
                                        return 'Phone Number must be up to 11 digits';
                                      }
                                      return null;
                                    },
                                    decoration: buildInputDecoration(
                                        Icons.phone, "Number"),

                                    // controller: empNo,
                                    // decoration: InputDecoration(
                                    //   focusedBorder: OutlineInputBorder(
                                    //     borderSide: BorderSide(
                                    //         color: Colors.black, width: 1),
                                    //   ),
                                    //   filled: true,
                                    //   fillColor: Colors.white,
                                    //   hintText: ('Employee Phone Number'),
                                    //   // errorText: _validate
                                    //   //     ? 'Value Can\'t Be Empty'
                                    //   //     : null,
                                    //   border: OutlineInputBorder(),
                                    //   contentPadding: EdgeInsets.only(left: 20),
                                    // ),
                                  )),
                              SizedBox(
                                  width: 200,
                                  height: 30,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    controller: salary,
                                    validator: (String value) {
                                      // salary.text = value;
                                      if (value.isEmpty) {
                                        return 'Please Employee salary';
                                      }
                                      if (!RegExp(r"^-?[0-9]+$")
                                          .hasMatch(value)) {
                                        return 'enter valid salary';
                                      }
                                      return null;
                                    },
                                    decoration: buildInputDecoration(
                                        Icons.money, "Salary"),
                                  )),
                              SizedBox(
                                width: 200,
                                height: 30,
                                child: TextFormField(
                                  enabled: false,
                                  //autofillHints: [AutofillHints.addressCity],
                                  textAlign: TextAlign.center,
                                  // validator: (String value) {
                                  //   status.text = value;
                                  //
                                  //   // if (!RegExp(
                                  //   //         r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$")
                                  //   //     .hasMatch(value)) {
                                  //   //   return 'valid status';
                                  //   // }
                                  //   return null;
                                  // },
                                  decoration: buildInputDecoration(
                                      Icons.save_sharp, "status is start"),
                                  // controller: status,
                                  // decoration: InputDecoration(
                                  //   focusedBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(
                                  //         color: Colors.black, width: 1),
                                  //   ),
                                  //   filled: true,
                                  //   fillColor: Colors.white,
                                  //   hintText: ('Employee Status'),
                                  //   // errorText: _validate
                                  //   //     ? 'Value Can\'t Be Empty'
                                  //   //     : null,
                                  //   border: OutlineInputBorder(),
                                  //   contentPadding: EdgeInsets.only(left: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 200,
                                height: 30,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  controller: attCount,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Please Employee attendance count';
                                    }
                                    if (!RegExp(r"^-?[0-9]+$")
                                        .hasMatch(value)) {
                                      return 'enter valid att Count';
                                    }
                                    return null;
                                  },
                                  decoration: buildInputDecoration(
                                      Icons.calculate_outlined,
                                      "Attendance count"),
                                  // controller: attCount,
                                  // decoration: InputDecoration(
                                  //   focusedBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(
                                  //         color: Colors.black, width: 1),
                                  //   ),
                                  //   filled: true,
                                  //   fillColor: Colors.white,
                                  //   hintText: ('attendance count ?'),
                                  //   // errorText: _validate
                                  //   //     ? 'Value Can\'t Be Empty'
                                  //   //     : null,
                                  //   border: OutlineInputBorder(),
                                  //   contentPadding: EdgeInsets.only(left: 20),
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                height: 30,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  controller: id,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Please Employee id';
                                    }
                                    if (!RegExp(r"^-?[0-9]+$")
                                        .hasMatch(value)) {
                                      return 'enter valid id';
                                    }
                                    return null;
                                  },
                                  decoration: buildInputDecoration(
                                      Icons.card_travel, "id"),
                                  // controller: id,
                                  // decoration: InputDecoration(
                                  //   focusedBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(
                                  //         color: Colors.black, width: 1),
                                  //   ),
                                  //   filled: true,
                                  //   fillColor: Colors.white,
                                  //   hintText: ('Employee id'),
                                  //   // errorText: _validate
                                  //   //     ? 'Value Can\'t Be Empty'
                                  //   //     : null,
                                  //   border: OutlineInputBorder(),
                                  //   contentPadding: EdgeInsets.only(left: 20),
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                height: 30,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  controller: wadges,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Please Employee salary';
                                    }
                                    if (!RegExp(r"^-?[0-9]+$")
                                        .hasMatch(value)) {
                                      return 'enter valid salary';
                                    }
                                    return null;
                                  },
                                  decoration: buildInputDecoration(
                                      Icons.money, "wadges"),
                                  // controller: wadges,
                                  // decoration: InputDecoration(
                                  //   focusedBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(
                                  //         color: Colors.black, width: 1),
                                  //   ),
                                  //   filled: true,
                                  //   fillColor: Colors.white,
                                  //   hintText: ('Employee Daily wadges'),
                                  //   // errorText: _validate
                                  //   //     ? 'Value Can\'t Be Empty'
                                  //   //     : null,
                                  //   border: OutlineInputBorder(),
                                  //   contentPadding: EdgeInsets.only(left: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          //mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                              child: TextButton(
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    bool result =
                                        await Employee.addEmployeeTodb(
                                            empName.text,
                                            empNo.text,
                                            salary.text,
                                            status.text,
                                            attCount.text,
                                            id.text,
                                            wadges.text);
                                    if (result) {
                                      _progressDialog.dismiss();
                                      Employee.showEmployeeDialog(
                                          title: 'New Employee ',
                                          message:
                                              'Saved Employee successfully',
                                          context: context);
                                    } else {
                                      Employee.showEmployeeDialog(
                                          title: 'New Employee',
                                          message: 'Cannot be saved ',
                                          context: context);
                                    }

                                    empName.clear();
                                    empNo.clear();
                                    salary.clear();
                                    status.clear();
                                    id.clear();
                                    wadges.clear();
                                    attCount.clear();
                                  }
                                },
                                child: Text(
                                  'Save Record',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black54),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: _visible ? false : true,
            child: TextButton(
              onPressed: () {
                setState(() {
                  _visible = true;
                });
              },
              child: Text(
                'Add new Employee',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.black54),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
