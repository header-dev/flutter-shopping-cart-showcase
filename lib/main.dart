import 'package:flutter/material.dart';
import 'package:shopping_cart/routes/app_routes.dart';
import 'package:shopping_cart/share.dart';
import 'package:shopping_cart/widgets/badge.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: AppRoutes.routes,
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _cartItemsCount = 0;
  int _navItemIndex = 0;

  @override
  build(BuildContext context) {
    Share.updateCartItem = (value) {
      setState(() {
        Share.cartItems = value;
        _cartItemsCount = Share.cartItemsCount();
      });
    };

    _navItemIndex = Share.navBarIndex;

    return Scaffold(
      body: AppRoutes.pages[_navItemIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedFontSize: 14,
        selectedFontSize: 14,
        currentIndex: _navItemIndex,
        items: bottomNavItems(),
        onTap: (index) => setState(() {
          Share.navBarIndex = index;
          _navItemIndex = Share.navBarIndex;
        }),
      ),
    );
  }

  List<BottomNavigationBarItem> bottomNavItems() {
    var navItemLabels = ['หน้าแรก', 'สินค้า', 'รถเข็น', 'เมนู'];

    var bgColors = [
      Colors.deepPurple,
      Colors.indigo,
      Colors.teal,
      Colors.brown,
    ];

    var navItemIcons = [
      Icons.home,
      Icons.apps,
      null,
      Icons.menu,
    ];

    var len = navItemIcons.length;

    return List.generate(
      len,
      (index) => BottomNavigationBarItem(
        label: navItemLabels[index],
        backgroundColor: bgColors[index],
        icon: (index != 2) ? Icon(navItemIcons[index]) : badge(_cartItemsCount),
      ),
    );
  }
}
