import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodyweb/firebase_services.dart';
import 'package:foodyweb/widget/category-Widget/categoryCardWidget.dart';

class CategoryListWidget extends StatefulWidget {
  @override
  _CategoryListWidgetState createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  FirebaseServices _services = FirebaseServices();

  @override
  @override
  Widget build(BuildContext context) {
//     return Container(
//       height: 150,
//       child: Expanded(
//         child: ListView.builder(
//           physics: ScrollPhysics(),
//           scrollDirection: Axis.horizontal,
//           itemCount: productsList?.length ?? 0,
//           shrinkWrap: true,
//           itemBuilder: (_, index) {
//             return Stack(children: [
//               SizedBox(
//                 height: 150,
//                 width: 150,
//                 child: Card(
//                   color: Colors.orangeAccent.withOpacity(.9),
//                   elevation: 4,
//                   child: Image.network(productsList[index].image),
//                 ),
//               ),
//               Positioned(
//                 child: CircleAvatar(
//                   child: IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.delete,
//                       color: Colors.red,
//                     ),
//                   ),
//                 ),
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Text(
//                     productsList[index].name,
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
//                   ),
//                 ],
//               )
//             ]);
//           },
//         ),
//       ),
//     );
//   }
// }

///////////////////////error./////////////////////////////////////////////
//   }
    return Container(
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
        stream: _services.category_r.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('something went wrong ......'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Wrap(
            direction: Axis.horizontal,
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return CategoryCard(document);
            }).toList(),
          );
        },
      ),
    );
  }
}
