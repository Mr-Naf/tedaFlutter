import 'package:cloud_firestore/cloud_firestore.dart';

class databaseMethods {
  Future addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

  Future addAllProducts(
    Map<String, dynamic> userInfoMap,
  ) async {
    return await FirebaseFirestore.instance
        .collection("Products")
        .add(userInfoMap);
  }

  Future AddProduct(
      Map<String, dynamic> userInfoMap, String categoryname) async {
    return await FirebaseFirestore.instance
        .collection(categoryname)
        .add(userInfoMap);
  }

  updateStatus(String id) async {
    return await FirebaseFirestore.instance
        .collection("Orders")
        .doc(id)
        .update({"Status": "Delivered"});
  }

  Future<Stream<QuerySnapshot>> getProducts(String category) async {
    return FirebaseFirestore.instance.collection(category).snapshots();
  }

  Future<Stream<QuerySnapshot>> allOrders() async {
    return FirebaseFirestore.instance
        .collection("Orders")
        .where("Status", isEqualTo: "On The Way")
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getOrders(String emil) async {
    return FirebaseFirestore.instance
        .collection("Orders")
        .where("Email", isEqualTo: emil)
        .snapshots();
  }

  Future orderDetails(Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("Orders")
        .add(userInfoMap);
  }

  Future<QuerySnapshot> search(String udatedname) async {
    return await FirebaseFirestore.instance
        .collection("Products")
        .where("SearchKey", isEqualTo: udatedname.substring(0, 1).toUpperCase())
        .get();
  }
}
