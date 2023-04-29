import 'dart:convert';

import 'package:http/http.dart' as http;

var url = 'http://192.168.56.1:3323/api/v1/shopping-cart';

Future<List<dynamic>> apiGetAllProducts() async {
  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var list = jsonDecode(response.body);
    return list;
  } else {
    throw Exception('http.get() error');
  }
}

Future<Map<String, dynamic>> apiGetProductById(int id) async {
  try {
    var response = await http.get(Uri.parse('$url/$id'));
    if (response.statusCode == 200) {
      var mapProduct = jsonDecode(response.body) as Map<String, dynamic>;
      return mapProduct;
    } else {
      throw Exception('http.get() error');
    }
  } catch (e) {
    throw Exception('Something really unknown: $e');
  }
}

Future<Map<String, dynamic>> apiAddProduct(int id) async {
  var response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'content-type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{'id': id}),
  );

  if (response.statusCode == 200) {
    var mapProduct = jsonDecode(response.body) as Map<String, dynamic>;
    return mapProduct;
  } else {
    throw Exception('http.get() error');
  }
}
