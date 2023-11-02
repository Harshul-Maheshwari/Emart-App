import 'package:ecommerce_app/consts/consts.dart';

class FirestoreServices {
  // get users data
  static getUser(uid) {
    return firestore
        .collection(userCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  // get products according to category
  static getProducts(category) {
    return firestore
        .collection(productsCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }
}
