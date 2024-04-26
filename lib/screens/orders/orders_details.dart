import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'orders_refactor.dart';

class OrdersDetailsPage extends StatefulWidget {
  final String orderId;

  OrdersDetailsPage({Key? key, required this.orderId});

  @override
  State<OrdersDetailsPage> createState() => _OrdersDetailsPageState();
}

class _OrdersDetailsPageState extends State<OrdersDetailsPage> {
  final firestore =
      FirebaseFirestore.instance.collection("AllOrderList").snapshots();

  @override
  Widget build(BuildContext context) {
    bool isChecked = true; // Initial state of the checkbox

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Update Order:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    // update the state of the checkbox
                    setState(() {
                      // isChecked = value ?? false;
                      if (value == true) {
                        print('hiiiii');
                        isChecked = false;
                      } else {
                        isChecked = true;
                      }
                    });
                  },
                ),
                Text('Order Updated'),
              ],
            ),
          ),
          Expanded(
            child: OrdersDetails(firestore: firestore, orderId: widget.orderId),
          ),
        ],
      ),
    );
  }
}
