import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../firebase/firestore.dart';

class ProductProvider extends ChangeNotifier {
  ProductImageProvider imageProvider = ProductImageProvider();

  List<String> itemTypesList = ["Pant", "Shirt", "T-shirt", "Shorts"];
  List<String> gendersList = ["Men", "Women", "Kids"];

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

  //function to add product detail to firestore after adding images to firebase storage.
  Future<void> addProductDetailToFireStore(
      TextEditingController productName,
      TextEditingController brandName,
      TextEditingController productPrice,
      List<String> imageUrls,
      TextEditingController quantity,
      TextEditingController color,
      String gender,
      String category
      // List<String> selectedSizes,
      ) async {
    String selectedGender =
        gender[0].toUpperCase() + gender.substring(1).toLowerCase();
    String selectedCategory =
        category[0].toUpperCase() + category.substring(1).toLowerCase();

    final currentDate = DateTime.now();
    String formattedDate =
        DateFormat('dd/MM/yyyy').format(currentDate).toString();

    final int id = DateTime.now().millisecondsSinceEpoch;
    await clothFirestoreCollection.doc(id.toString()).set({
      "id": id.toString().trim(),
      "name": productName.text.trim(),
      "gender": selectedGender.trim(),
      "category": selectedCategory.trim(),
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

  Future<void> editProductDetailToFireStore(
      String id,
      TextEditingController productName,
      TextEditingController brandName,
      TextEditingController productPrice,
      List imageUrls,
      TextEditingController quantity,
      TextEditingController color,
      TextEditingController gender,
      TextEditingController category
      // List<String> selectedSizes,
      ) async {
    String selectedGender =
        gender.text[0].toUpperCase() + gender.text.substring(1).toLowerCase();
    String selectedCategory = category.text[0].toUpperCase() +
        category.text.substring(1).toLowerCase();
    final currentDate = DateTime.now();
    String formattedDate =
        DateFormat('dd/MM/yyyy').format(currentDate).toString();

    // final int id = DateTime.now().millisecondsSinceEpoch;
    await clothFirestoreCollection.doc(id).update({
      "id": id.toString().trim(),
      "name": productName.text.trim(),
      "gender": selectedGender.trim(),
      "category": selectedCategory.trim(),
      "brand": brandName.text.trim(),
      "price": productPrice.text.trim(),
      "imageUrl": imageUrls,
      "time": formattedDate,
      "size": selectedSize,
      "Quantity": quantity.text.trim(),
      "color": color.text.trim()
    });
    imageUrls.clear();
  }

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
        await FirebaseFirestore.instance.collection("Clothes").doc(id).get();
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

  // Future<void> pickImage() async {
  //   try {
  //     final FilePickerResult? result = await FilePicker.platform
  //         .pickFiles(type: FileType.image, allowMultiple: true);
  //     if (result != null) {
  //       List<Uint8List?> imageDataList =
  //           result.files.map((file) => file.bytes).toList();
  //       _imageData.addAll(imageDataList);
  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }

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

  //Upload imageList to firebase storage
  // Future<List<String>> uploadImagesToFireStore(String productName) async {
  //   final FilePickerResult? result = await FilePicker.platform
  //       .pickFiles(type: FileType.image, allowMultiple: true);
  //   if (result != null) {
  //     for (int i = 0; i < result.files.length; i++) {
  //       Uint8List? imageData = result.files[i].bytes;
  //       String imageName = '${productName}_$i';

  //       String imageUrl =
  //           await addImageUrlToFirebaseStorge(imageData!, imageName);
  //       imageUrls.add(imageUrl);
  //       notifyListeners();
  //     }
  //   }
  //   notifyListeners();
  //   return imageUrls;
  // }
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
        imageUrls.add(imageUrl); // Append the new URL to the list
        notifyListeners();
      }
    }
    return imageUrls; // Return the updated list after all images are uploaded
  }

  Future<String> addImageUrlToFirebaseStorge(
      Uint8List imageData, String imageName) async {
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
