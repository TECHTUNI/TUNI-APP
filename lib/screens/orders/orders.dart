import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tuni_web/screens/orders/orders_details.dart';

class MessagesPage extends StatelessWidget {
  MessagesPage({super.key});

  final firestore =
      FirebaseFirestore.instance.collection('AllOrderList').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              StreamBuilder(
                stream: firestore,
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data == null) {
                    return const Center(
                        child:
                            CircularProgressIndicator()); // Add loading indicator or handle accordingly
                  }
                  final length = snapshot.data!.docs.length;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: length,
                    itemBuilder: (context, index) {
                      final orderId = snapshot.data!.docs[index]['orderId'];
                      if (orderId == null) {
                        return const SizedBox.shrink();
                      }
                      final stream = FirebaseFirestore.instance
                          .collection("AllOrderList")
                          .doc(orderId)
                          .snapshots();
                      return StreamBuilder(
                        stream: stream,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData || snapshot.data == null) {
                            return const SizedBox.shrink();
                          }
                          final email = snapshot.data!.get("email");
                          if (email == null) {
                            return const SizedBox.shrink();
                          }
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        OrdersDetailsPage(orderId: orderId),
                                  ));
                            },
                            child: ListTile(
                              title: Text(orderId),
                              subtitle: Text(email),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
