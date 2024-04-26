import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DashBoardContainers extends StatelessWidget {
  const DashBoardContainers(
      {super.key, required this.stream, required this.text});

  final Stream<QuerySnapshot<Map<String, dynamic>>> stream;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 130,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: List.filled(
              1,
              BoxShadow(
                  color: Colors.grey.shade300, spreadRadius: 1, blurRadius: 10),
              growable: true)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final count = snapshot.data!.docs.length;
                  return Text(
                    count.toString(),
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
