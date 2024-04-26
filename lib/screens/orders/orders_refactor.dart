import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrdersDetails extends StatelessWidget {
  const OrdersDetails({
    super.key,
    required this.firestore,
    required this.orderId,
  });

  final Stream<QuerySnapshot<Map<String, dynamic>>> firestore;
  final String orderId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: StreamBuilder<QuerySnapshot>(
        stream: firestore,
        builder: (context, snapshot) {
          final stream = FirebaseFirestore.instance
              .collection('AllOrderList')
              .doc(orderId)
              .snapshots();
          return StreamBuilder(
            stream: stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: Container(child: CircularProgressIndicator()));
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }

              final productIds = snapshot.data!.get("productId");

              return ListView.builder(
                itemCount: productIds.length,
                itemBuilder: (context, index) {
                  final productId = productIds[index]["productId"];
                  // final quantity = productIds[index]["quantity"];
                  final userName = snapshot.data!.get("userName");
                  final email = snapshot.data!.get("email");
                  final phone = snapshot.data!.get("phone");

                  return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Clothes')
                        .doc(productId)
                        .snapshots(),
                    builder: (context, productSnapshot) {
                      if (productSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (productSnapshot.hasError) {
                        return Text("Error: ${productSnapshot.error}");
                      }

                      final productDetails = productSnapshot.data!.data();
                      final productName = productDetails?['name'] ?? 'N/A';
                      final productBrand = productDetails?['brand'] ?? 'N/A';

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 500, vertical: 10),
                        child: Container(
                          decoration:
                              BoxDecoration(color: Colors.grey.shade300),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text("SR. NO.: ${index + 1}"),
                                const SizedBox(height: 10),
                                Text("Product ID: $productId"),
                                const SizedBox(height: 10),
                                Text("Product Name: $productName"),
                                const SizedBox(height: 10),
                                Text("Product Brand: $productBrand"),
                                const SizedBox(height: 10),
                                Text("User Name: $userName"),
                                const SizedBox(height: 10),
                                Text("email: $email"),
                                const SizedBox(height: 10),
                                Text("Contact no.: $phone"),
                                const SizedBox(height: 10),
                                Text("Ordered Quantity: $phone"),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
