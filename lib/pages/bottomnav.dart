import "package:flashy_tab_bar2/flashy_tab_bar2.dart";
import "package:flutter/material.dart";
import "package:my_flutter_app/pages/home.dart";
import "package:my_flutter_app/pages/order.dart";
import "package:my_flutter_app/pages/profile.dart";

class Bottomnav extends StatefulWidget {
  const Bottomnav({super.key});

  @override
  State<Bottomnav> createState() => _BottomnavState();
}

class _BottomnavState extends State<Bottomnav> {
  late List<Widget> pages;

  late home HomePage;
  late Order order;
  late Profile profile;
  int currentTabIndex = 0;

  @override
  void initState() {
    HomePage = home();
    order = Order();
    profile = Profile();

    pages = [HomePage, order, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: currentTabIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          currentTabIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            title: Text('Home'),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.shop_2_outlined),
            title: Text('Card'),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.person_2_outlined),
            title: Text('Profile'),
          ),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
