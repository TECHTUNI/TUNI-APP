import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tuni_web/screens/Dashboard/dashboard_refactor.dart';
import '../refactor/refactor.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;
    final productStream =
        FirebaseFirestore.instance.collection("Clothes").snapshots();
    final allOrderStream =
        FirebaseFirestore.instance.collection("AllOrderList").snapshots();
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(children: [
        pageHeadings('Dashboard'),
        SizedBox(
          height: screenHeight * .2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DashBoardContainers(
                text: "No. of Products: ", stream: productStream),
            DashBoardContainers(
                text: "No. of Orders: ", stream: allOrderStream),
          ],
        ),
      ]),
    );
  }
}
