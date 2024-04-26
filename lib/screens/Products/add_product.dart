import 'package:flutter/material.dart';
import 'package:tuni_web/screens/Products/add_products_refactor.dart';

class AddProductToFirestore extends StatelessWidget {
  AddProductToFirestore({super.key});

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController brandNameController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController colorController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Add New Product'),
      ),
      backgroundColor: Colors.grey.shade300,
      body: AddProduct(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        formKey: formKey,
        productNameController: productNameController,
        colorController: colorController,
        brandNameController: brandNameController,
        productPriceController: productPriceController,
        quantityController: quantityController,
      ),
    );
  }
}
