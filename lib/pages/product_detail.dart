import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping_cart/data/apiClient/shoppingCart/api.dart';
import 'package:shopping_cart/share.dart';
import 'package:shopping_cart/widgets/badge.dart';

class ProductDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProductDetailPageState();
}

class ProductDetailPageState extends State<ProductDetailPage> {
  late Future<Map<String, dynamic>> future;
  var id = 0;
  var price = 0;
  bool _aplCalling = true;
  var product = {};
  var fmt = NumberFormat.decimalPattern();

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    id = args['id'];

    future = apiGetProductById(id);
    future.then((value) {
      product = value;
      setState(() {
        _aplCalling = false;
      });
    });

    return Scaffold(
      appBar: buildAppBar(context, 'รายละเอียดสินค้า'),
      body: (_aplCalling)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      product['imgUrl'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  column2(),
                  SizedBox(
                    height: 25,
                  ),
                  column3(),
                ],
              ),
            ),
    );
  }

  Widget column2() => ListTile(
        title: Text(
          '${product['name']}',
          textScaleFactor: 1.5,
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${fmt.format(product['price'])}',
          textScaleFactor: 1.2,
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.add_shopping_cart,
            size: 36,
            color: Colors.green,
          ),
          onPressed: () {
            var cartItems = Share.cartItems as List<Map<String, dynamic>>;

            bool existing = false;

            setState(() {
              cartItems.forEach((element) {
                if (element['id'] == id) {
                  element['quantity'] += 1;
                  Share.cartItems = cartItems;
                  existing = true;
                }
              });
            });

            if (!existing) {
              cartItems.add({
                'id': product['id'],
                'name': product['name'],
                'quantity': 1,
                'imgUrl': product['imgUrl'],
              });
            }
          },
        ),
      );

  Widget column3() => Container(
        alignment: Alignment.centerLeft,
        child: Text('${product['detail']}'),
      );

  AppBar buildAppBar(BuildContext context, String title) {
    int _cartItemCount = Share.cartItemsCount();

    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              Share.navBarIndex = 0;
            });
            Navigator.pop(context);
          },
          icon: Icon(Icons.home),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 15,
          ),
          child: IconButton(
            icon: badge(_cartItemCount),
            onPressed: () {
              setState(() {
                Share.navBarIndex = 2;
              });
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
  }
}
