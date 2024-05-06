import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuni_web/model/Product_model.dart';
import 'package:tuni_web/screens/Products/add_products_refactor.dart';
import 'package:tuni_web/screens/Products/products_detail_page.dart';

import '../../provider/product_provider.dart';
import '../refactor/refactor.dart';
import 'add_product.dart';

// class ProductsPage extends StatelessWidget {
//   const ProductsPage({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: Colors.grey.shade200,
//       body: SingleChildScrollView(
//         child: Column(children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 55),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 pageHeadings('Add New Product'),
//                 TextButton.icon(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => AddProductToFirestore()));
//                   },
//                   icon: const Icon(Icons.add),
//                   label: const Text('Add Products'),
//                 )
//               ],
//             ),
//           ),
//           const SizedBox(height: 30),
//           Container(
//             width: screenWidth * .82,
//             height: screenHeight * .83,
//             decoration: BoxDecoration(
//                 color: Colors.white, borderRadius: BorderRadius.circular(15)),
//             child: Column(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                       color: Colors.blueGrey.shade200,
//                       borderRadius: const BorderRadius.only(
//                           topRight: Radius.circular(15),
//                           topLeft: Radius.circular(15))),
//                   width: screenWidth,
//                   height: 60,
//                   child: Center(
//                     child: Table(
//                       children: [
//                         TableRow(children: [
//                           // SizedBox(width: 10),
//                           Center(child: productListingHeadings("No.")),
//                           Center(child: productListingHeadings("Name")),
//                           Center(child: productListingHeadings("ID")),
//                           Center(child: productListingHeadings("Brand")),
//                           Center(child: productListingHeadings("Gender")),
//                           Center(child: productListingHeadings("Quantity")),
//                           Center(child: productListingHeadings("Time")),
//                           Center(child: productListingHeadings("Price")),
//                           const Center(child: SizedBox())
//                         ])
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Consumer<ProductImageProvider>(
//                     builder: (BuildContext context, image, Widget? child) {
//                       return StreamBuilder<QuerySnapshot>(
//                         stream: combineStreams([
//                           "full sleve",
//                           "half sleve",
//                           "collar",
//                           "round neck",
//                           "v-neck",
//                         ]),
//                         builder: (
//                           BuildContext context,
//                           AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
//                         ) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return const Center(
//                                 child: CircularProgressIndicator());
//                           }
//                           if (snapshot.hasError) {
//                             return const Text("Error fetching data");
//                           }

//                           return ListView.builder(
//                             itemCount: snapshot.data!.docs.length,
//                             itemBuilder: (context, index) {
//                               String productID =
//                                   snapshot.data!.docs[index].id.toString();
//                               String productName =
//                                   snapshot.data!.docs[index]['name'].toString();
//                               String brandName = snapshot
//                                   .data!.docs[index]['brand']
//                                   .toString();
//                               String gender = snapshot
//                                   .data!.docs[index]['gender']
//                                   .toString();
//                               String availableQuantity = snapshot
//                                   .data!.docs[index]['Quantity']
//                                   .toString();
//                               String addedDate =
//                                   snapshot.data!.docs[index]['time'].toString();
//                               String color = snapshot.data!.docs[index]['color']
//                                   .toString();
//                               String price = snapshot.data!.docs[index]['price']
//                                   .toString();
//                               List<dynamic> imageUrl =
//                                   snapshot.data!.docs[index]['imageUrl'];
//                               List<dynamic> sizes =
//                                   snapshot.data!.docs[index]['size'];
//                               return InkWell(
//                                 onTap: () {
//                                   print(imageUrl);
//                                   final Productdetails productdetails =
//                                       Productdetails(
//                                           id: productID,
//                                           name: productName,
//                                           brand: brandName,
//                                           gender: gender,
//                                           price: price,
//                                           time: addedDate,
//                                           imageUrlList: imageUrl,
//                                           quantity: availableQuantity,
//                                           color: color,
//                                           size: sizes);
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => ProductDetailPage(
//                                           productdetails: productdetails,
//                                         ),
//                                       ));
//                                 },
//                                 child: tableRowProductListing(
//                                     screenWidth: screenWidth,
//                                     screenHeight: screenHeight,
//                                     context: context,
//                                     index: index,
//                                     name: productName,
//                                     id: productID,
//                                     brand: brandName,
//                                     gender: gender,
//                                     price: price,
//                                     quantity: availableQuantity,
//                                     time: addedDate,
//                                     imageUrlList: imageUrl,
//                                     deleteProduct: (String id) =>
//                                         image.deleteProductFromFirestore(
//                                             id, imageUrl),
//                                     sizes: sizes),
//                               );
//                             },
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 )
//               ],
//             ),
//           )
//         ]),
//       ),
//     );
//   }
// }

// Stream<QuerySnapshot<Object?>> combineStreams(List<String> types) async* {
//   List<Stream<QuerySnapshot<Object?>>> streams = [];

//   for (String type in types) {
//     CollectionReference collectionRef = FirebaseFirestore.instance
//         .collection("clothes")
//         .doc("Men")
//         .collection("Tshirt")
//         .doc(type)
//         .collection("Plain");
//     streams.add(collectionRef.snapshots());
//   }

//   await for (var snapshotsList in CombineLatestStream.list(streams)) {
//     List<QueryDocumentSnapshot<Object?>> combinedList = [];
//     for (var snapshots in snapshotsList) {
//       combinedList.addAll(snapshots.docs);
//     }
//     print;
//     for (int i = 0; i <= 0; i++) {
//       yield snapshotsList[i];
//     }
//   }
// }
class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  pageHeadings('Add New Product'),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddProductToFirestore(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Products'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: screenWidth * .82,
              height: screenHeight * .83,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade200,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      ),
                    ),
                    width: screenWidth,
                    height: 60,
                    child: Center(
                      child: Table(
                        children: [
                          TableRow(children: [
                            Center(child: productListingHeadings("No.")),
                            Center(child: productListingHeadings("Name")),
                            Center(child: productListingHeadings("ID")),
                            Center(child: productListingHeadings("Brand")),
                            Center(child: productListingHeadings("Gender")),
                            Center(child: productListingHeadings("Quantity")),
                            Center(child: productListingHeadings("Time")),
                            Center(child: productListingHeadings("Price")),
                            const Center(child: SizedBox()),
                          ]),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Consumer<ProductProvider>(
                      builder: (BuildContext context, productProvider,
                          Widget? child) {
                        final productsFuture =
                            productProvider.fetchAllProducts();

                        return FutureBuilder<List<Productdetails>>(
                          future: productsFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text("Error: ${snapshot.error}"));
                            } else {
                              final List<Productdetails> products =
                                  snapshot.data ?? [];

                              return ListView.builder(
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  final product = products[index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailPage(
                                            productdetails: product,
                                          ),
                                        ),
                                      );
                                    },
                                    child: tableRowProductListing(
                                      screenWidth: screenWidth,
                                      screenHeight: screenHeight,
                                      context: context,
                                      index: index,
                                      name: product.name,
                                      id: product.id,
                                      brand: product.brand,
                                      gender: product.gender,
                                      price: product.price,
                                      quantity: product.quantity,
                                      time: product.time,
                                      imageUrlList: product.imageUrlList,
                                      sizes: product.size,
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
