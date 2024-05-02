import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuni_web/screens/Products/products.dart';
import '../../provider/drop_down_provider.dart';
import '../../provider/product_provider.dart';
import '../refactor/refactor.dart';
import 'edit_product.dart';

Widget productMainTexts(String text, double width) {
  return Text(
    text,
    style: TextStyle(
        fontSize: width * 0.025, letterSpacing: 2, fontWeight: FontWeight.bold),
  );
}

Widget productSubTexts(String text, double width, [String? content]) {
  final contentText = content ?? "";
  return Text(
    "$contentText$text, ",
    style: TextStyle(fontSize: width * 0.0125, letterSpacing: 2),
  );
}

ProductImageProvider imageProvider = ProductImageProvider();

Widget tableRowProductListing(
    {required BuildContext context,
    required int index,
    required String name,
    required String id,
    required String brand,
    required String gender,
    required String quantity,
    required String time,
    required String price,
    required List<dynamic> imageUrlList,
    required List<dynamic> sizes,
    required Function(String id) deleteProduct,
    required double screenWidth,
    required double screenHeight}) {
  TableRow tableRow = TableRow(children: <Widget>[
    Center(child: productListingHeadings("${index + 1}")),
    Center(child: productListingHeadings(name.toUpperCase())),
    Center(child: productListingHeadings(id)),
    Center(child: productListingHeadings(brand.toUpperCase())),
    Center(child: productListingHeadings(gender.toUpperCase())),
    Center(child: productListingHeadings(quantity)),
    Center(child: productListingHeadings(time)),
    Center(child: productListingHeadings("₹$price/-")),
    Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              onPressed: () {
                imageProvider.existingImage;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProductsDetail(
                              id: id,
                              imageUrl: imageUrlList,
                              sizes: sizes,
                            )));
              },
              icon: const Icon(
                Icons.edit,
                size: 20,
              )),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Are you sure?"),
                        content:
                            const Text("Do you want to delete this product?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )),
                          TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                await deleteProduct(id);
                              },
                              child: const Text(
                                "Delete",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      );
                    });
              },
              icon: const Icon(
                Icons.delete,
                size: 20,
                color: Colors.red,
              )),
          const SizedBox()
        ],
      ),
    )
  ]);
  return SizedBox(
    height: 50,
    child: Center(
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          tableRow,
        ],
      ),
    ),
  );
}

class AddProduct extends StatelessWidget {
  final List<String> itemList = ["Shirt", "Pants", "Tshirt", "Short"];
  final List<String> pants = [
    "Jogger",
    "Six pocket",
    "Jeans",
  ];
  final List<String> gender = ["Men", "Women"];
  final List<String> types = [
    "full sleve",
    "half sleve",
    "collar",
    "round neck",
    "v-neck",
  ];
  final List<String> design = ["Plain", "Printed", "check"];
  AddProduct({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.formKey,
    required this.productNameController,
    required this.colorController,
    required this.brandNameController,
    required this.productPriceController,
    required this.quantityController,
  });

  final double screenHeight;
  final double screenWidth;
  final GlobalKey<FormState> formKey;
  final TextEditingController productNameController;
  final TextEditingController colorController;
  final TextEditingController brandNameController;
  final TextEditingController productPriceController;
  final TextEditingController quantityController;
  // final TextEditingController genderController;

  List<String> imageUrls = [];

  late String cat;
  late String type;
  late String selected_design;
  late String selectedpant;
  late String selected_gender;

  @override
  Widget build(BuildContext context) {
    DropdownProvider provider =
        Provider.of<DropdownProvider>(context, listen: true);
    cat = provider.selectedItem;
    type = provider.selectedtype;
    selected_design = provider.selecteddesign;
    selectedpant = provider.selectedpant;
    selected_gender = provider.Selectedgender;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 250),
      child: SingleChildScrollView(
        child: Consumer2<ProductProvider, ProductImageProvider>(
          builder: (BuildContext context, product, image, Widget? child) {
            return Column(
              // backgroundColor: Colors.grey.shade200,
              children: [
                SizedBox(
                  height: screenHeight,
                  width: screenWidth,
                  child: Form(
                    key: formKey,
                    child: ListView(
                      children: [
                        // const Text('Pick images'),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Consumer<ProductProvider>(
                              builder:
                                  (BuildContext context, value, Widget? child) {
                                return ElevatedButton(
                                  onPressed: () async {
                                    // image.pickImage();

                                    imageUrls =
                                        await image.uploadImagesToFireStore(
                                            productNameController.text);
                                  },
                                  child: const Text('Add Product Images'),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // border: Border.all(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 300,
                          child: GridView.builder(
                            itemCount: imageUrls.isEmpty ? 0 : imageUrls.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemBuilder: (context, index) {
                              // Uint8List? imageBytes = image.imageList.isNotEmpty
                              //     ? image.imageList[index]
                              //     : null;

                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Stack(children: [
                                  SizedBox(
                                    // color: Colors.red,
                                    height: 200,
                                    width: 200,
                                    child: imageUrls.isNotEmpty
                                        ? Image.network(
                                            imageUrls[index].toString())
                                        : const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                  ),
                                  Positioned(
                                      left: 35,
                                      child: IconButton(
                                          onPressed: () {
                                            image.deleteParticularImage(
                                                index, imageUrls);
                                          },
                                          icon: const Icon(Icons.close))),
                                ]),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 10),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Product name cannot be empty!!";
                            }
                            return null;
                          },
                          controller: productNameController,
                          decoration: const InputDecoration(
                            hintText: 'Product name',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 10),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Product color!!";
                            }
                            return null;
                          },
                          controller: colorController,
                          decoration: const InputDecoration(
                            hintText: 'Product Color',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                            child: Consumer<DropdownProvider>(
                              builder: (context, dropdownProvider, ___) {
                                return DropdownButton<String>(
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 92, 90, 90)
                                          .withOpacity(0.8),
                                      fontSize: 15),
                                  value: dropdownProvider.Selectedgender,
                                  onChanged: (String? gender) {
                                    dropdownProvider.setgender(gender!);
                                  },
                                  items: gender.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                            child: Consumer<DropdownProvider>(
                              builder: (context, dropdownProvider, _) {
                                return DropdownButton<String>(
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 92, 90, 90)
                                          .withOpacity(0.8),
                                      fontSize: 15),
                                  value: dropdownProvider.selectedItem,
                                  onChanged: (String? newItem) {
                                    dropdownProvider.setSelectedItem(newItem!);
                                  },
                                  items: itemList.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        Visibility(
                          visible: provider.selectedItem == 'Tshirt',
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                              child: Consumer<DropdownProvider>(
                                builder: (context, dropdownProvider, child) {
                                  return DropdownButton<String>(
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 92, 90, 90)
                                          .withOpacity(0.8),
                                      fontSize: 15,
                                    ),
                                    value: dropdownProvider.selectedtype,
                                    onChanged: (String? newItem) {
                                      dropdownProvider.change(newItem!);
                                    },
                                    items: types.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Visibility(
                          visible: provider.selectedItem == "Tshirt",
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                              child: Consumer<DropdownProvider>(
                                builder: (context, dropdownProvider, child) {
                                  return DropdownButton<String>(
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 92, 90, 90)
                                          .withOpacity(0.8),
                                      fontSize: 15,
                                    ),
                                    value: dropdownProvider.selecteddesign,
                                    onChanged: (String? newDesign) {
                                      dropdownProvider.changedesign(newDesign!);
                                    },
                                    items: design.map((String value) {
                                      debugPrint(design.toString());
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: provider.selectedItem == "Pants",
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                              child: Consumer<DropdownProvider>(
                                builder: (context, dropdownProvider, __) {
                                  return DropdownButton<String>(
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 92, 90, 90)
                                          .withOpacity(0.8),
                                      fontSize: 15,
                                    ),
                                    value: dropdownProvider.selectedpant,
                                    onChanged: (String? newpant) {
                                      dropdownProvider.setpant(newpant!);
                                    },
                                    items: pants.map((String value) {
                                      debugPrint(design.toString());
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Brand name cannot be empty!!";
                            }
                            return null;
                          },
                          controller: brandNameController,
                          decoration: const InputDecoration(
                            hintText: 'Brand name',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Price cannot be empty!!";
                                  }
                                  if (int.parse(value) < 1) {
                                    return "Price should be greater than zero";
                                  }
                                  return null;
                                },
                                controller: productPriceController,
                                decoration: const InputDecoration(
                                  hintText: 'Price',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Quantity cannot be empty!!";
                                  }
                                  if (int.parse(value) < 1) {
                                    return "Quantity should be greater than zero";
                                  }
                                  return null;
                                },
                                controller: quantityController,
                                decoration: const InputDecoration(
                                  hintText: 'Quantity',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text('Select available sizes:'),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 350,
                          child: ListView.builder(
                            itemCount: product.productSizes.length,
                            itemBuilder: (context, index) {
                              final sizes = product.productSizes[index];
                              return CheckboxListTile(
                                value: product.selectedSizes.contains(sizes),
                                onChanged: (bool? value) {
                                  product.selectProductSizes(value!, index);
                                },
                                title: Text(sizes),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),

                        const SizedBox(height: 30),
                        SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState?.validate() == true) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ProductsPage(),
                                    ),
                                    (route) => false);
                                await product.addProductDetailToFireStore(
                                    productNameController,
                                    brandNameController,
                                    productPriceController,
                                    image.imageUrls,
                                    quantityController,
                                    colorController,
                                    selected_gender,
                                    cat,
                                    type,
                                    selected_design);
                                // image.clearImageList();
                                product.selectedSizes.clear();
                              }
                            },
                            child: const Text('Add Product'),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
