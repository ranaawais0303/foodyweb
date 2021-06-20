import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodyweb/Orders/order_provider.dart';
import 'package:foodyweb/Orders/order_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyOrders extends StatefulWidget {
  static const String id = 'Orders';
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  ScrollController _controller;
  OrderServices _OrderServices = OrderServices();
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
    var _orderProvider = Provider.of<OrderProvider>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Container(
        //   height: 56,
        //   width: MediaQuery.of(context).size.width,
        //   child: ChipsChoice<int>.single(
        //     choiceActiveStyle: C2ChoiceStyle(
        //       color: Colors.teal,
        //     ),
        //     choiceStyle: C2ChoiceStyle(
        //       borderRadius: BorderRadius.all(Radius.circular(3)),
        //     ),
        //     value: tag,
        //     onChanged: (val) => setState(() {
        //       if (val == 0) {
        //         setState(() {
        //           _orderProvider.status = null;
        //         });
        //       }
        //       setState(() {
        //         tag = val;
        //         _orderProvider.filterOrder(options[val]);
        //       });
        //     }),
        //     choiceItems: C2Choice.listFrom<int, String>(
        //       source: options,
        //       value: (i, v) => i,
        //       label: (i, v) => v,
        //     ),
        //   ),
        // ),
        Container(
          height: MediaQuery.of(context).size.height,
          child: StreamBuilder<QuerySnapshot>(
            stream: _OrderServices.orders
                // .where('userId', isEqualTo: user.uid)
                .where('orderStatus',
                    isEqualTo: tag > 0 ? _orderProvider.status : null)
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
                                  color: document.data()['orderStatus'] ==
                                          'Rejected'
                                      ? Colors.red
                                      : document.data()['orderStatus'] ==
                                              'Accepted'
                                          ? Colors.blueGrey
                                          : Colors.orangeAccent,
                                ),
                              ),
                              title: Text(
                                document.data()['orderStatus'],
                                style: TextStyle(
                                    fontSize: 12,
                                    color: document.data()['orderStatus'] ==
                                            'Rejected'
                                        ? Colors.red
                                        : document.data()['orderStatus'] ==
                                                'Accepted'
                                            ? Colors.blueGrey
                                            : Colors.orangeAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'On ${DateFormat.yMMMd().format(
                                  DateTime.parse(document.data()['timestamp']),
                                )}',
                                style: TextStyle(fontSize: 12),
                              ),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Payment : ${document.data()['cod']}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Amount : PKR ${document.data()['total'].toStringAsFixed(0)}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            ExpansionTile(
                              title: Text(
                                'Order details',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.black),
                              ),
                              subtitle: Text(
                                'View order details',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              children: [
                                ListView.builder(
                                  controller: _controller,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  //physics: NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        ListTile(
                                          leading: CircleAvatar(
                                            //radius: 20,
                                            backgroundColor: Colors.white,
                                            child: Image.network(
                                                document.data()['products']
                                                    [index]['productImage']),
                                          ),
                                          title: Text(
                                            document.data()['products'][index]
                                                ['productName'],
                                            style: TextStyle(fontSize: 13),
                                          ),
                                          subtitle: Text(
                                            '${document.data()['products'][index]['quantity'].toString()} x PKR ${document.data()['products'][index]['productPrice'].toString()}',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  itemCount: document.data()['products'].length,
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
                                                'Discount : ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13),
                                              ),
                                              Text(
                                                document
                                                    .data()['discount']
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
                                          Row(
                                            children: [
                                              Text(
                                                'Delivery Fee : ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13),
                                              ),
                                              Text(
                                                document
                                                    .data()['deliverFee']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 13),
                                              )
                                            ],
                                          )
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
                            document.data()['orderStatus'] == 'Ordered'
                                ? Column(
                                    children: [
                                      document.data()['orderStatus'] ==
                                              'Accepted'
                                          ? Container(
                                              height: 50,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        40, 8, 40, 8),
                                                // child: TextButton(
                                                //   onPressed: () {
                                                //     showDialog(
                                                //         'Ready',
                                                //         'Ready to Deliver',
                                                //         document.id,
                                                //         context);
                                                //   },
                                                child: Text(
                                                  'Assign Delivery boy',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  // ),
                                                  // style: ButtonStyle(
                                                  //   backgroundColor:
                                                  //       MaterialStateProperty.all<Color>(
                                                  //           Colors.orange),
                                                  // ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              color: Colors.grey,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: TextButton(
                                                        onPressed: () {
                                                          showDialog(
                                                              'Accept order',
                                                              'Accepted',
                                                              document.id,
                                                              context);
                                                        },
                                                        child: Text(
                                                          'Accept',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(Colors
                                                                      .blueGrey),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: AbsorbPointer(
                                                        absorbing: document
                                                                        .data()[
                                                                    'orderStatus'] ==
                                                                'Rejected'
                                                            ? true
                                                            : false,
                                                        child: TextButton(
                                                          onPressed: () {
                                                            showDialog(
                                                                'Reject order',
                                                                'Rejected',
                                                                document.id,
                                                                context);
                                                          },
                                                          child: Text(
                                                            'Reject',
                                                            style: TextStyle(
                                                                color: document.data()[
                                                                            'orderStatus'] ==
                                                                        'Rejected'
                                                                    ? Colors
                                                                        .grey
                                                                    : Colors
                                                                        .red),
                                                          ),
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all<Color>(
                                                                        Colors
                                                                            .blueGrey),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ],
                                  )
                                : Divider(
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
                  status == 'Accepted'
                      ? _OrderServices.updateOrderStatus(documentId, status)
                          .then((value) {
                          EasyLoading.showSuccess('updated successfully');
                        })
                      : _OrderServices.updateOrderStatus(documentId, status)
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
