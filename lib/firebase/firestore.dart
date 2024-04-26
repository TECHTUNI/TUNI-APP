import 'package:cloud_firestore/cloud_firestore.dart';

//collections
final CollectionReference clothFirestoreCollection = FirebaseFirestore.instance.collection('Clothes');



//documents
final  menDocument = clothFirestoreCollection.doc('products');



//firebase storage rules
// rules_version = '2';
//
// // Craft rules based on data in your Firestore database
// // allow write: if firestore.get(
// //    /databases/(default)/documents/users/$(request.auth.uid)).data.isAdmin;
// service firebase.storage {
// match /b/{bucket}/o {
// match /{allPaths=**} {
// allow read, write: if request.auth != null;
// }
// }
// }
