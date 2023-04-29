import 'package:flutter/material.dart';
import 'package:shopping_cart/share.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  var cartItems = [];

  @override
  Widget build(BuildContext context) {
    cartItems = Share.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: Text('รถเข็น'),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        alignment: Alignment.topCenter,
        child: (cartItems.length > 0)
            ? ListView.separated(
                itemCount: cartItems.length,
                itemBuilder: (ctx, idx) => buildListTile(idx),
                separatorBuilder: (ctx, idx) => Divider(
                  thickness: 1,
                  color: Colors.indigo,
                ),
              )
            : Text(
                'ไม่มีสินค้าในรถเข็น',
                textScaleFactor: 1.5,
              ),
      ),
    );
  }

  Widget buildListView() => ListView.separated(
        itemCount: cartItems.length,
        itemBuilder: (ctx, i) => buildListTile(i),
        separatorBuilder: (ctx, i) => Divider(
          thickness: 1,
          color: Colors.indigo,
        ),
      );

  Widget buildListTile(int index) => ListTile(
        contentPadding: const EdgeInsets.only(
          top: 5,
          bottom: 5,
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            cartItems[index]['imgUrl'],
            width: 60.0,
          ),
        ),
        title: Text(
          cartItems[index]['name'],
          textScaleFactor: 1.3,
          maxLines: 2,
        ),
        trailing: rowQuantity(index),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/product_detail',
            arguments: {
              'id': cartItems[index]['id'],
            },
          ).then((value) {
            Share.updateCartItem(Share.cartItems);
          });
        },
      );

  Widget rowQuantity(int index) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          OutlinedButton(
            style: btnStyle(),
            child: Text(
              '-',
              textScaleFactor: 1.3,
            ),
            onPressed: () {
              setState(() {
                var item = cartItems[index];
                if (item['quantity'] > 0) {
                  item['quantity'] -= 1;
                  if (item['quantity'] == 0) {
                    cartItems.removeAt(index);
                  }
                }
                Share.updateCartItem(cartItems);
              });
            },
          ),
          Text(
            ' ${cartItems[index]['quantity']} ',
            textScaleFactor: 1.4,
          ),
          OutlinedButton(
            style: btnStyle(),
            child: Text(
              '+',
              textScaleFactor: 1.3,
            ),
            onPressed: () {
              setState(() {
                var item = cartItems[index];
                item['quantity'] += 1;
              });
              Share.updateCartItem(cartItems);
            },
          ),
        ],
      );

  ButtonStyle btnStyle() => OutlinedButton.styleFrom(
        minimumSize: Size(30, 30),
        side: BorderSide(
          color: Colors.black26,
          width: 1.2,
          style: BorderStyle.solid,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );
}
