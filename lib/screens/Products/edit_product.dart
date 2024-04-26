import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/product_provider.dart';
import 'edit_product_refactor.dart';

class EditProductsDetail extends StatefulWidget {
  final String id;
  final List imageUrl;
  final List sizes;

  const EditProductsDetail({super.key, required this.id, required this.imageUrl, required this.sizes});

  @override
  State<EditProductsDetail> createState() => EditProductsDetailState();
}

class EditProductsDetailState extends State<EditProductsDetail> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController brandNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController categoryController = TextEditingController();


  @override
  void initState() {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final imageProvider =
        Provider.of<ProductImageProvider>(context, listen: false);
    productProvider.fetchData(
        id: widget.id,
        productNameController: productNameController,
        brandNameController: brandNameController,
        colorController: colorController,
        productPriceController: productPriceController,
        quantityController: quantityController,
        genderController: genderController,
        categoryController: categoryController);

    imageProvider.fetchImageFromFireStore(widget.id);
    super.initState();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(),
      body: EditProduct(
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        formKey: formKey,
        id: widget.id,
        productNameController: productNameController,
        colorController: colorController,
        brandNameController: brandNameController,
        productPriceController: productPriceController,
        quantityController: quantityController,
        genderController: genderController,
        categoryController: categoryController,
        imageUrlList: widget.imageUrl,
        existingSizes: widget.sizes,
      ),
    );
  }
}

