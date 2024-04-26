import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuni_web/model/Product_model.dart';
import 'package:tuni_web/screens/Products/add_products_refactor.dart';
import '../../provider/product_provider.dart';

class ProductDetailPage extends StatelessWidget {
  Productdetails productdetails;
  // final int index;
  // final String name;
  // final String id;
  // final String brand;
  // final String gender;
  // final String price;
  // final String time;
  // final List<dynamic> imageUrlList;
  // final String quantity;
  // final String color;
  // final List<dynamic> size;

  // const ProductDetailPage({
  //   super.key,
  //   required this.index,
  //   required this.name,
  //   required this.id,
  //   required this.brand,
  //   required this.gender,
  //   required this.price,
  //   required this.time,
  //   required this.imageUrlList,
  //   required this.quantity,
  //   required this.color,
  //   required this.size,
  // });
  ProductDetailPage({super.key, required this.productdetails});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      body: Consumer<ImageDetailPageProvider>(
        builder: (BuildContext context, detailedImage, Widget? child) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  child: SizedBox(
                height: height * 0.9,
                width: width * 0.1,
              )
                  // ImageDetailPageProvider(),
                  ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: SizedBox(
              //     height: height * 0.9,
              //     width: width * 0.1,
              //     child: GridView.builder(
              //       gridDelegate:
              //           const SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 1,
              //       ),
              //       itemCount: productdetails.imageUrlList.length,
              //       itemBuilder: (context, index) {
              //         return InkWell(
              //           onTap: () {
              //             detailedImage.selectedImage(index);
              //           },
              //           child:
              //            Container(
              //             height: 250,
              //             width: 250,
              //             margin: const EdgeInsets.all(8.0),
              //             decoration: BoxDecoration(
              //               image: DecorationImage(
              //                 image: NetworkImage(productdetails
              //                     .imageUrlList[index]
              //                     .toString()),
              //                 fit: BoxFit.cover,
              //               ),
              //             ),
              //           ),
              //         );
              //       },
              //     ),
              //   ),
              // ),
              // Container(
              //   height: height * .9,
              //   width: width * .4,
              //   decoration: detailedImage.selectedIndex <
              //           productdetails.imageUrlList.length
              //       ? BoxDecoration(
              //           image: DecorationImage(
              //               image: NetworkImage(productdetails
              //                   .imageUrlList[detailedImage.selectedIndex])))
              //       : null,
              // ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    height: height,
                    width: width,
                    // color: Colors.blue,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            productMainTexts(productdetails.name, width),
                            productMainTexts('₹${productdetails.price}', width),
                          ],
                        ),
                        const SizedBox(height: 20),
                        productSubTexts(
                            productdetails.brand, width, "Brand Name: "),
                        const SizedBox(height: 10),
                        productSubTexts(productdetails.color, width, "Color: "),
                        const SizedBox(height: 10),
                        SizedBox(
                          // color: Colors.teal,
                          height: 30,
                          width: width * 0.2,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Text(
                                "Sizes Available: ",
                                style: TextStyle(
                                    fontSize: width * 0.0125, letterSpacing: 2),
                              ),
                              const SizedBox(width: 8),
                              for (var sizeItem in productdetails.size)
                                productSubTexts(sizeItem, width),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
