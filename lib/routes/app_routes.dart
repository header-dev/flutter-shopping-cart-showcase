import 'package:shopping_cart/main.dart';
import 'package:shopping_cart/pages/cart.dart';
import 'package:shopping_cart/pages/home.dart';
import 'package:shopping_cart/pages/product_detail.dart';
import 'package:shopping_cart/pages/products.dart';
import 'package:shopping_cart/pages/settings.dart';

class AppRoutes {
  static String mainPage = '/';
  static String productDetailPage = '/product_detail';
  static String cartPage = '/cart';

  static var routes = {
    '/': (context) => MainPage(),
    '/product_detail': (context) => ProductDetailPage(),
    '/cart': (context) => CartPage()
  };

  static var pages = [
    HomePage(),
    ProductPage(),
    CartPage(),
    SettingPage(),
  ];
}
