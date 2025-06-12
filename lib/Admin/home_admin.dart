import 'package:flutter/material.dart';
import 'package:my_flutter_app/Admin/add_product.dart';
import 'package:my_flutter_app/Admin/all_orders.dart';
import 'package:my_flutter_app/widget/support_widget.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          "Admin Home",
          style: AppWidget.boldTextFeildStyle().copyWith(
            fontSize: 22,
            color: Colors.black87,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddProduct()));
              },
              child: Material(
                elevation: 6.0,
                shadowColor: Colors.orange.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 25),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: const [Color(0xFFFFF3E0), Color(0xFFFFFFFF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_circle_outline_sharp,
                          size: 40, color: Colors.deepOrange),
                      SizedBox(width: 15),
                      Text(
                        "Add Product",
                        style: AppWidget.boldTextFeildStyle().copyWith(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllOrders()));
              },
              child: Material(
                elevation: 6.0,
                shadowColor: Colors.blueGrey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 25),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: const [Color(0xFFE3F2FD), Color(0xFFFFFFFF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart_outlined,
                          size: 40, color: Colors.blueGrey),
                      SizedBox(width: 15),
                      Text(
                        "All Orders",
                        style: AppWidget.boldTextFeildStyle().copyWith(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
