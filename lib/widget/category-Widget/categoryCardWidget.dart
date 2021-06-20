import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:foodyweb/firebase_services.dart';

class CategoryCard extends StatelessWidget {
  final DocumentSnapshot document;
  FirebaseServices _services = FirebaseServices();
  CategoryCard(this.document);
  @override
  Widget build(BuildContext context) {
//     return Container(
//       child: ListView.builder(
//           physics: ScrollPhysics(),
//       scrollDirection: Axis.horizontal,
//       shrinkWrap: true,
//       itemBuilder: (_, index) {
//       return Stack(children: [
//       SizedBox(
//       height: 180,
//       width: 180,
//       child:Card(
//       color: Colors.orangeAccent.withOpacity(.9),
//       elevation: 4,
//       child: Image.network(document['image']),),
//       Positioned(
//       child: CircleAvatar(
//       child: IconButton(
//       onPressed: () {},
//       icon: Icon(
//       Icons.delete,
//       color: Colors.red,
//       ),
//       ),
//       ),
//       ),
//       Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//        Text(document['name']),
//
//       ],
//       ),
//         ]);
//       },
//       ),
//     ),);
//   }
// }
    return Container(
        height: 150,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Stack(children: [
            SizedBox(
              height: 180,
              width: 180,
              child: Card(
                color: Colors.orangeAccent.withOpacity(.9),
                elevation: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    document['image'],
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              child: CircleAvatar(
                child: IconButton(
                  onPressed: () {
                    _services.ConfirmDeleteDialog(
                        title: '${document['name']}',
                        message: 'do u want to delete the info ',
                        context: context,
                        id: document.id);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  document['name'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                Text(
                  document['price'].toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ],
            )
          ]),
        ));
  }
}
