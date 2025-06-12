import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/pages/category_product.dart';
import 'package:my_flutter_app/pages/product_detail.dart';
import 'package:my_flutter_app/services/database.dart';
import 'package:my_flutter_app/services/shared_pref.dart';
import 'package:my_flutter_app/widget/support_widget.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  bool search = false;
  List categories = [
    "images/men1.webp",
    "images/girl.jpeg",
    "images/kid.jpeg",
    "images/shoe.jpeg",
  ];
  List Categoryname = ["Men", "Women", "Childern", "shoe"];

  var queryResulSet = [];
  var tempSearchStore = [];
  TextEditingController searchcontoller = TextEditingController();
  initiateSearch(String value) {
    if (value.isEmpty) {
      setState(() {
        queryResulSet = [];
        tempSearchStore = [];
        search = false;
      });
      return;
    }

    setState(() {
      search = true;
    });

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResulSet.isEmpty && value.length == 1) {
      databaseMethods().search(value).then((QuerySnapshot docs) {
        queryResulSet = docs.docs.map((doc) => doc.data()).toList();

        tempSearchStore = queryResulSet
            .where((element) =>
                element['UpdatedName'].startsWith(capitalizedValue))
            .toList();

        setState(() {});
      });
    } else {
      tempSearchStore = queryResulSet
          .where(
              (element) => element['UpdatedName'].startsWith(capitalizedValue))
          .toList();

      setState(() {});
    }
  }

  String? name, image;
  getthesharedpref() async {
    name = await SharedPreferenceHelper().getUserName();
    image = await SharedPreferenceHelper().getUserImage();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: name == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.only(top: 55.0, left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hey ${name!}",
                            style: AppWidget.boldTextFeildStyle().copyWith(
                              fontSize: 22,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text("Welcome",
                              style: AppWidget.LightTextFeildStyle()),
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(35.0),
                        child: Image.network(
                          image!,
                          height: 70.0,
                          width: 70.0,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),

                  // Search Bar
                  SizedBox(height: 30.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: TextField(
                      controller: searchcontoller,
                      onChanged: (value) {
                        initiateSearch(value.toUpperCase());
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search Products",
                        hintStyle: AppWidget.LightTextFeildStyle(),
                        prefixIcon: search
                            ? GestureDetector(
                                onTap: () {
                                  search = false;
                                  tempSearchStore = [];
                                  queryResulSet = [];
                                  searchcontoller.text = "";
                                  setState(() {});
                                },
                                child: Icon(Icons.close, color: Colors.grey),
                              )
                            : Icon(Icons.search, color: Colors.grey),
                      ),
                    ),
                  ),

                  SizedBox(height: 25.0),

                  // Search Results or Main Content
                  search
                      ? Expanded(
                          child: ListView(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            children:
                                tempSearchStore.map(builResultCard).toList(),
                          ),
                        )
                      : Expanded(
                          child: ListView(
                            children: [
                              // Categories
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Categories",
                                    style: AppWidget.semiBoldTextFeildStyle(),
                                  ),
                                  Text(
                                    "See All",
                                    style: TextStyle(
                                      color: Color(0xFFfd6f3e),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 16.0),

                              Row(
                                children: [
                                  Container(
                                    height: 130.0,
                                    width: 90,
                                    margin: EdgeInsets.only(right: 20.0),
                                    padding: EdgeInsets.all(20.0),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFD6F3E),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.elliptical(100, 100),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "All",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: 130.0,
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: categories.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return CategoryTile(
                                            image: categories[index],
                                            name: Categoryname[index],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 25.0),

                              // All Products
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "All Products",
                                    style: AppWidget.semiBoldTextFeildStyle(),
                                  ),
                                  Text(
                                    "See All",
                                    style: TextStyle(
                                      color: Color(0xFFfd6f3e),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),

                              SizedBox(height: 20.0),

                              SizedBox(
                                height: 260.0,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    // Product 1
                                    Container(
                                      margin: EdgeInsets.only(right: 20),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 6,
                                            offset: Offset(0, 4),
                                          )
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            "images/men.jpeg",
                                            height: 140.0,
                                            width: 140.0,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "Men Shirt",
                                            style: AppWidget
                                                .semiBoldTextFeildStyle(),
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Text(
                                                "LKR 2000",
                                                style: TextStyle(
                                                  color: Color(0xFFfd6f3e),
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(width: 30.0),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFfd6f3e),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),

                                    // Product 2
                                    Container(
                                      margin: EdgeInsets.only(right: 20),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 6,
                                            offset: Offset(0, 4),
                                          )
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            "images/girl.jpeg",
                                            height: 140.0,
                                            width: 140.0,
                                            fit: BoxFit.cover,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "Female",
                                            style: AppWidget
                                                .semiBoldTextFeildStyle(),
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Text(
                                                "LKR 3000",
                                                style: TextStyle(
                                                  color: Color(0xFFfd6f3e),
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(width: 30.0),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFfd6f3e),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                ],
              ),
            ),
    );
  }

  Widget builResultCard(data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetail(
                    image: data["Image"],
                    detail: data["Detail"],
                    name: data["Name"],
                    price: data["Price"])));
      },
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        height: 100,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                data["Image"],
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              data["Name"],
              style: AppWidget.semiBoldTextFeildStyle(),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  String image, name;
  CategoryTile({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryProduct(category: name)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 20.0),
        padding: EdgeInsets.only(right: 20.0, left: 20, top: 50),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              image,
              height: 50.0,
              width: 50.0,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
