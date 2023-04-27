import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

Widget badge(dynamic cartItemCount) {
  var showBadge = false;
  var padding = 4.0;

  if (cartItemCount > 0) {
    showBadge = true;

    if (cartItemCount < 10) {
      padding = 7.0;
    }
  }

  return badges.Badge(
    child: Icon(
      Icons.shopping_cart,
      color: Colors.white,
    ),
    badgeContent: Text(
      '$cartItemCount',
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
    showBadge: showBadge,
    badgeStyle: badges.BadgeStyle(
      badgeColor: Colors.orange,
      padding: EdgeInsets.all(padding),
    ),
    position: badges.BadgePosition.topEnd(),
    badgeAnimation: badges.BadgeAnimation.fade(),
  );
}
