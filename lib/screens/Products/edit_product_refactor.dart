import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuni_web/screens/side_nav.dart';
import '../../provider/product_provider.dart';

class EditProduct extends StatelessWidget {
  EditProduct(
      {super.key,
      required this.screenHeight,
      required this.screenWidth,
      required this.formKey,
      required this.id,
      required this.productNameController,
      required this.colorController,
      required this.brandNameController,
      required this.productPriceController,
      required this.quantityController,
      required this.genderController,
      required this.categoryController,
      required this.imageUrlList,
      required this.existingSizes});

  final List imageUrlList;
  final double screenHeight;
  final double screenWidth;
  final GlobalKey<FormState> formKey;
  final String id;
  final TextEditingController productNameController;
  final TextEditingController colorController;
  final TextEditingController brandNameController;
  final TextEditingController productPriceController;
  final TextEditingController quantityController;
  final TextEditingController genderController;
  final TextEditingController categoryController;
  final List existingSizes;

  final List existingList = [];

  @override
  Widget build(BuildContext context) {
    existingList.addAll(imageUrlList);
    debugPrint(existingSizes.toString());
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
                                    List<String> newImages =
                                        await image.uploadImagesToFireStore(id);
                                    existingList.addAll(newImages);
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
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 250,
                          child: GridView.builder(
                            itemCount: existingList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                            ),
                            itemBuilder: (context, index) {
                              final imageUrl = existingList[index];

                              return Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 200,
                                      width: 200,
                                      child: Image.network(imageUrl),
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 70,
                                    child: IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        image
                                            .deleteParticularImageFromEditImagePage(
                                                index, existingList);
                                      },
                                    ),
                                  ),
                                ],
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
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter gender!!";
                            } else if (value.toLowerCase() != "men" &&
                                value.toLowerCase() != "women" &&
                                value.toLowerCase() != "kids") {
                              return "please enter Men, Women or kid!!! (don't make spelling mistake)";
                            }
                            return null;
                          },
                          controller: genderController,
                          decoration: const InputDecoration(
                            hintText: 'Gender',
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
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter gender!!";
                            } else if (value.toLowerCase() != "shirt" &&
                                value.toLowerCase() != "pant" &&
                                value.toLowerCase() != "tshirt" &&
                                value.toLowerCase() != "short") {
                              return "please enter whether shirt, pant, tshirt or short! (don't make spelling mistake)";
                            }
                            return null;
                          },
                          controller: categoryController,
                          decoration: const InputDecoration(
                            hintText: 'Gender',
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
                          child: Consumer<ProductProvider>(
                            builder: (context, product, child) {
                              return ListView.builder(
                                itemCount: product.productSizes.length,
                                itemBuilder: (context, index) {
                                  final size = product.productSizes[index];
                                  final isSizeSelected =
                                      existingSizes.contains(size);

                                  return CheckboxListTile(
                                    value: isSizeSelected,
                                    onChanged: (bool? value) {
                                      if (value != null) {
                                        if (value) {
                                          existingSizes.add(
                                              size); // Add the size if checked
                                        } else {
                                          existingSizes.remove(
                                              size); // Remove the size if unchecked
                                        }
                                      }
                                      product.editProductSizes(
                                          value!, index, existingSizes);
                                    },
                                    title: Text(size),
                                  );
                                },
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 10),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState?.validate() == true) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SideNavPage(),
                                    ),
                                    (route) => false);
                                await product.editProductDetailToFireStore(
                                    id,
                                    productNameController,
                                    brandNameController,
                                    productPriceController,
                                    existingList,
                                    quantityController,
                                    colorController,
                                    genderController,
                                    categoryController);
                                image.clearImageList();
                                product.selectedSizes.clear();
                              }
                            },
                            child: const Text('Update Product'),
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
