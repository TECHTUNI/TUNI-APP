import 'dart:html';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tuni_web/screens/Products/products_detail_page.dart';
import '../firebase/firestore.dart';
import '../model/Product_model.dart';

class ProductProvider extends ChangeNotifier {
  ProductImageProvider imageProvider = ProductImageProvider();

  List<String> itemTypesList = ["Pant", "Shirt", "T-shirt", "Shorts"];
  List<String> gendersList = ["Men", "Women", "Kids"];
  final List<String> pants = [
    "Jogger",
    "Six pocket",
    "Jeans",
  ];
  final List<String> types = [
    "full sleve",
    "half sleve",
    "collar",
    "round neck",
    "v-neck",
  ];
  final List<String> design = ["Plain", "Printed", "check"];

  String? selectedValue;
  String? selectedGender;
  String? existingValue;
  String? existingGender;

  void setSelectedItem(String? value, [String? id]) async {
    selectedValue = value;

    notifyListeners();
  }

  void setSelectedGender(String? value, [String? id]) {
    selectedGender = value;
    notifyListeners();
  }

  Future<String> setExistingSelectedItem([String? id]) async {
    final DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection("Clothes").doc(id).get();
    final String category = documentSnapshot['category'];

    return category;
  }

  Future<String> setExistingSelectedGender([String? id]) async {
    final DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection("Clothes").doc(id).get();
    final String gender = documentSnapshot['gender'];

    return gender;
  }

  Future<List<Productdetails>> fetchallProducts() async {
    try {
      List<Productdetails> products = [];

      // Define arrays for collections and documents
      List<String> genderList = ["Men", "Women", "Kids"];
      List<String> categoryList = ["Shirt", "Pant", "T-shirt", "Shorts"];
      List<String> typeList = [
        "full sleve",
        "half sleve",
        "collar",
        "round neck",
        "v-neck"
      ];
      List<String> designList = ["Plain", "Printed", "check"];

      List<String> pants = ["Jogger", "Six pocket", "Jeans"];

      // Iterate through each combination of collections and documents
      for (String gender in genderList) {
        for (String category in categoryList) {
          for (String type in typeList) {
            for (String design in designList) {
              // Construct the Firestore path
              QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                  .collection("clothes")
                  .doc(gender)
                  .collection(category)
                  .doc(type)
                  .collection(design)
                  .get();

              // Process the documents in the query snapshot
              querySnapshot.docs.forEach((doc) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                Productdetails product = Productdetails(
                  id: data['id'].toString(),
                  name: data['name'].toString(),
                  brand: data['brand'].toString(),
                  gender: data['gender'].toString(),
                  price: data['price'].toString(),
                  time: data['time'].toString(),
                  imageUrlList: List<String>.from(data['imageUrl'] ?? []),
                  quantity: data['Quantity'].toString(),
                  color: data['color'].toString(),
                  size: List<String>.from(data['size'] ?? []),
                );
                products.add(product);
                for (int i = 0; i <= products.length; i++) {
                  print(product.name);
                }
              });
            }
          }
        }
      }

      return products;
    } catch (e) {
      print("Error fetching products: $e");
      throw e; // Rethrow the error to handle it in the calling code
    }
  }

  // Future<List<Productdetails>> fetchallProducts() async {
  //   try {
  //     List<Productdetails> products = [];

  //     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //         .collection("clothes")
  //         .doc("Men")
  //         .collection("Shirt")
  //         .doc("full sleve")
  //         .collection("Plain")
  //         .get();

  //     print('query snaa${querySnapshot.docs}');
  //     querySnapshot.docs.forEach((doc) {
  //       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //       Productdetails product = Productdetails(
  //         id: data['id'].toString(),
  //         name: data['name'].toString(),
  //         brand: data['brand'].toString(),
  //         gender: data['gender'].toString(),
  //         price: data['price'].toString(),
  //         time: data['time'].toString(),
  //         imageUrlList: List<String>.from(data['imageUrl'] ?? []),
  //         quantity: data['Quantity'].toString(),
  //         color: data['color'].toString(),
  //         size: List<String>.from(data['size'] ?? []),
  //       );
  //       products.add(product);
  //       print(products[0].brand);
  //     });

  //     return products;
  //   } catch (e) {
  //     print("Error fetching products: $e");
  //     throw e; // Rethrow the error to handle it in the calling code
  //   }
  // }

  // Future<List<Productdetails>> fetchallProducts() async {
  //   try {
  //     List<Productdetails> products = [];

  //     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //         .collection("clothes")
  //         .doc("Men")
  //         .collection("Shirt")
  //         .doc("full sleve")
  //         .collection("plain")
  //         .get();

  //     querySnapshot.docs.forEach((doc) {
  //       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //       Productdetails product = Productdetails.fromJson(data);
  //       products.add(product);
  //     });

  //     return products;
  //   } catch (e) {
  //     print("Error fetching products: $e");
  //     throw e; // Rethrow the error to handle it in the calling code
  //   }
  // }

  Future<void> addProductDetailToFireStore(
    TextEditingController productName,
    TextEditingController brandName,
    TextEditingController productPrice,
    List<String> imageUrls,
    TextEditingController quantity,
    TextEditingController color,
    String gender,
    String category,
    String design,
    String type,
  ) async {
    print('hiiiiiiiiiiiiiiiii$imageUrls');
    String selectedGender =
        gender[0].toUpperCase() + gender.substring(1).toLowerCase();
    String selectedCategory =
        category[0].toUpperCase() + category.substring(1).toLowerCase();

    final currentDate = DateTime.now();
    String formattedDate =
        DateFormat('dd/MM/yyyy').format(currentDate).toString();

    final int id = DateTime.now().millisecondsSinceEpoch;

    await FirebaseFirestore.instance
        .collection("clothes")
        .doc(gender.toString())
        .collection(selectedCategory.toString())
        .doc(design.toString())
        .collection(type.toString())
        .doc(id.toString())
        .set({
      "id": id.toString().trim(),
      "name": productName.text.trim(),
      "gender": selectedGender.trim(),
      "brand": brandName.text.trim(),
      "price": productPrice.text.trim(),
      "imageUrl": imageUrls,
      "time": formattedDate,
      "size": selectedSize,
      "Quantity": quantity.text.trim(),
      "color": color.text.trim(),
    });

    imageUrls.clear();
  }

  // Future<void> addProductDetailToFireStore(
  //   TextEditingController productName,
  //   TextEditingController brandName,
  //   TextEditingController productPrice,
  //   List<String> imageUrls,
  //   TextEditingController quantity,
  //   TextEditingController color,
  //   String gender,
  //   String category,
  //   String design,
  //   String type,
  // ) async {
  //   print('typeeeeeeeeeeeee${type}');
  //   // Capitalize the first letter of gender and category
  //   String selectedGender =
  //       gender[0].toUpperCase() + gender.substring(1).toLowerCase();
  //   String selectedCategory =
  //       category[0].toUpperCase() + category.substring(1).toLowerCase();

  //   // Get the current date and format it
  //   final currentDate = DateTime.now();
  //   String formattedDate =
  //       DateFormat('dd/MM/yyyy').format(currentDate).toString();

  //   // Generate a unique ID for the product
  //   final int id = DateTime.now().millisecondsSinceEpoch;

  //   // Create the product details map
  //   Map<String, dynamic> productDetails = {
  //     "id": id.toString(),
  //     "name": productName.text.trim(),
  //     "gender": selectedGender.trim(),
  //     "brand": brandName.text.trim(),
  //     "price": productPrice.text.trim(),
  //     "imageUrl": imageUrls,
  //     "time": formattedDate,
  //     "size": selectedSize, // Assuming selectedSize is defined elsewhere
  //     "Quantity": quantity.text.trim(),
  //     "color": color.text.trim(),
  //   };

  //  Map<String, dynamic> designMAp{

  //  }

  //   Map<String, dynamic> typeMap = {
  //     type: {
  //       design: [productDetails]
  //     }
  //   };

  //   Map<String, dynamic> categoryMap = {
  //     category: typeMap,
  //   };

  //   Map<String, dynamic> genderMap = {
  //     selectedGender: categoryMap,
  //   };

  //   // Add the product to Firestore
  //   await FirebaseFirestore.instance
  //       .collection("clotheu")
  //       .doc(selectedGender)
  //       .set(genderMap, SetOptions(merge: true));

  //   // Clear the list of image URLs after adding the product
  //   imageUrls.clear();
  // }

  // Future<void> editProductDetailToFireStore(
  //     String id,
  //     TextEditingController productName,
  //     TextEditingController brandName,
  //     TextEditingController productPrice,
  //     List imageUrls,
  //     TextEditingController quantity,
  //     TextEditingController color,
  //     TextEditingController gender,
  //     TextEditingController category
  //     // List<String> selectedSizes,
  //     ) async {
  //   String selectedGender =
  //       gender.text[0].toUpperCase() + gender.text.substring(1).toLowerCase();
  //   String selectedCategory = category.text[0].toUpperCase() +
  //       category.text.substring(1).toLowerCase();
  //   final currentDate = DateTime.now();
  //   String formattedDate =
  //       DateFormat('dd/MM/yyyy').format(currentDate).toString();

  //   // final int id = DateTime.now().millisecondsSinceEpoch;
  //  await FirebaseFirestore.instance
  //       .collection("clothes")
  //       .doc(gender.toString())
  //       .collection(selectedCategory.toString())
  //       .doc(design.toString())
  //       .collection(type.toString())
  //       .doc(id.toString()) .doc(id).update({
  //     "id": id.toString().trim(),
  //     "name": productName.text.trim(),
  //     "gender": selectedGender.trim(),
  //     "category": selectedCategory.trim(),
  //     "brand": brandName.text.trim(),
  //     "price": productPrice.text.trim(),
  //     "imageUrl": imageUrls,
  //     "time": formattedDate,
  //     "size": selectedSize,
  //     "Quantity": quantity.text.trim(),
  //     "color": color.text.trim()
  //   });
  //   imageUrls.clear();
  // }

  Future<void> fetchData({
    required String id,
    required TextEditingController productNameController,
    required TextEditingController brandNameController,
    required TextEditingController colorController,
    required TextEditingController productPriceController,
    required TextEditingController quantityController,
    required TextEditingController genderController,
    required TextEditingController categoryController,
  }) async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection("Cloth").doc(id).get();
    final String name = documentSnapshot['name'];
    final String brandName = documentSnapshot['brand'];
    final String color = documentSnapshot['color'];
    final String price = documentSnapshot['price'];
    final String quantity = documentSnapshot['Quantity'];
    final String gender = documentSnapshot["gender"];
    final String category = documentSnapshot["category"];

    // final List<String> imageUrlList = documentSnapshot['imageUrl'];
    // final List<String> size = documentSnapshot['size'];

    productNameController.text = name;
    brandNameController.text = brandName;
    colorController.text = color;
    productPriceController.text = price;
    quantityController.text = quantity;
    genderController.text = gender;
    categoryController.text = category;
  }

  //checkbox for selecting sizes
  bool isSelected = false;
  List<String> selectedSizes = [];
  List<String> productSizes = ["XS", "S", "M", "L", "XL", "XXL"];

  void selectProductSizes(bool value, int index) {
    if (value == true) {
      if (!selectedSizes.contains(productSizes[index])) {
        selectedSizes.add(productSizes[index]);
      }
    } else {
      selectedSizes.remove(productSizes[index]);
    }
    notifyListeners();
  }

  void editProductSizes(bool value, int index, List existingSizes) {
    selectedSizes.clear();
    selectedSizes = List<String>.from(existingSizes);

    if (value == true) {
      if (!selectedSizes.contains(productSizes[index])) {
        selectedSizes.add(productSizes[index]);
      }
    } else {
      selectedSizes.remove(productSizes[index]);
    }

    notifyListeners();
  }

  // ================ Provider Getter ======================================
  String? get selectedItemGetter => selectedValue;
  String? get selectedGenderGetter => selectedGender;

  String? get existingGenderGetter => existingGender;
  String? get existingValueGetter => existingValue;

  List<String> get selectedSize => selectedSizes;
}

class ProductImageProvider extends ChangeNotifier {
  //Add images to Firebase

  final List<String> imageUrls = [];
  List<String> existingImage = [];

  Future<List<String>> fetchImageFromFireStore(String id) async {
    final DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('Clothes').doc(id).get();
    if (documentSnapshot.exists) {
      existingImage = (documentSnapshot['imageUrl'] as List).cast<String>();
      return existingImage;
    } else {
      return [];
    }
  }

  Future<List<String>> uploadImagesToFireStore(String productName) async {
    final FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);
    if (result != null) {
      for (int i = 0; i < result.files.length; i++) {
        Uint8List? imageData = result.files[i].bytes;
        String imageName =
            '${productName}_${DateTime.now().millisecondsSinceEpoch}';

        String imageUrl =
            await addImageUrlToFirebaseStorge(imageData!, imageName);
        imageUrls.add(imageUrl);
        notifyListeners();
      }
    }
    return imageUrls;
  }

  Future<String> addImageUrlToFirebaseStorge(
      Uint8List imageData, String imageName) async {
    print('image url$imageName');
    final firebase_storage.Reference ref = firebase_storage
        .FirebaseStorage.instance
        .ref('/product_images/$imageName');

    firebase_storage.UploadTask uploadTask = ref.putData(imageData);

    await uploadTask;

    var imageUrl = await ref.getDownloadURL();

    return imageUrl;
  }

// To clear the image list after adding.
  void clearImageList() {
    imageUrls.clear();
    notifyListeners();
  }

  void deleteParticularImage(int index, List imageUrl) {
    imageUrl.remove(imageUrls[index]);
    notifyListeners();
  }

  void deleteParticularImageFromEditImagePage(int index, List imageList) {
    imageList.remove(imageList[index]);
    notifyListeners();
  }

  // to delete the delete product from firestore!!

  Future<void> deleteProductFromFirestore(
      String id, List<dynamic> imageUrlList) async {
    try {
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection("Clothes").doc(id);
      await documentReference.delete();
      for (dynamic i in imageUrlList) {
        await firebase_storage.FirebaseStorage.instance.ref(i).delete();
      }

      notifyListeners();
    } catch (e) {
      throw e.toString();
    }
  }

  List<String?> get imageList => imageUrls;
  List<String> get existingImages => existingImage;
}

class ImageDetailPageProvider extends ChangeNotifier {
  int selectedIndex = 0;

  void selectedImage(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
