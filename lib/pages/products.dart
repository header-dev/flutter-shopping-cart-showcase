import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping_cart/data/apiClient/shoppingCart/api.dart';
import 'package:shopping_cart/share.dart';

class ProductPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProductPageState();
}

class ProductPageState extends State<ProductPage> {
  late Future<List<dynamic>> allProducts;
  var listProducts = [];
  bool _apiCalling = true;
  var fmt = NumberFormat.decimalPattern();

  @override
  initState() {
    super.initState();

    allProducts = apiGetAllProducts();

    allProducts.then((value) {
      for (var p in value) {
        listProducts.add(p);
      }
      setState(() {
        _apiCalling = false;
      });
    });
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สินค้า'),
      ),
      body: (_apiCalling)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              itemCount: listProducts.length,
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (context, index) => ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: buildGridTile(index),
              ),
            ),
    );
  }

  Widget buildGridTile(int index) => InkWell(
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            title: Text(
              listProducts[index]['name'],
              textScaleFactor: 1.3,
              maxLines: 1,
            ),
            subtitle: Text('${fmt.format(listProducts[index]['price'])}'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 32,
              color: Colors.white,
            ),
          ),
          child: Image.network(
            listProducts[index]['imgUrl'],
          ),
        ),
        onTap: () => Navigator.pushNamed(context, '/product_detail',
            arguments: {'id': listProducts[index]['id']}).then((value) {
          Share.updateCartItem(Share.cartItems);
        }),
      );
}
