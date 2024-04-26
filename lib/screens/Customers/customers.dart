// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class CustomersPage extends StatelessWidget {
//   CustomersPage({super.key});

//   final firestore = FirebaseFirestore.instance.collection('AllOrderList').snapshots();



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Customers'),
//       ),
//       body:  SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: Column(
//             children: [
//               StreamBuilder(stream: firestore, builder: (context, snapshot) {
//                 final length = snapshot.data!.docs.length;
//                 return ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: length,
//                   itemBuilder: (context, index) {
//                     final orderId = snapshot.data!.docs[index]['orderId'];
//                     return ListTile(
//                       title: Text(orderId),
//                     );
//                   },);
//               },)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
