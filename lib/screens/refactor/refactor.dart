import 'package:flutter/material.dart';

Widget pageHeadings(String heading) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Text(
      heading,
      style: const TextStyle(fontSize: 20, letterSpacing: 1),
    ),
  );
}

Widget dashBoardFirstLine() {
  return Container(
    width: 200,
    height: 100,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: List.filled(
            1,
            BoxShadow(
                color: Colors.grey.shade300, spreadRadius: 1, blurRadius: 10),
            growable: true)),
  );
}

Widget productListingHeadings(String headingText) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0), // Add padding to the top
    child: Text(
      headingText,
      style: const TextStyle(letterSpacing: 1),
    ),
  );
}
