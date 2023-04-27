import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var title = 'Workshop 16';
  var subTitle = 'Shopping Cart';
  var body = 'คลิกปุ่ม สินค้า เพื่อเลือกรายการ\n' +
      'คลิกสินค้าที่ต้องการเพื่อดูรายละเอียด\n' +
      'ถ้าต้องการสินค้าใด ให้หยิบใส่รถเข็น\n' +
      'คลิกปุ่ม รถเข็น เพื่อดูรายการที่เลือก\n' +
      'คลิกปุ่ม -/+ เพื่อแก้ไขจำนวนในรถเข็น';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('หน้าแรก'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                title,
                textScaleFactor: 2.0,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                subTitle,
                textScaleFactor: 1.7,
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                body,
                textScaleFactor: 1.3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
