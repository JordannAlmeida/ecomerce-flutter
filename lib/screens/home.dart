import 'package:flutter/material.dart';
import 'package:my_ecommerce_jordann/tabs/homeTab.dart';
import 'package:my_ecommerce_jordann/tabs/productsTab.dart';
import 'package:my_ecommerce_jordann/widges/customDrawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final _pageController = PageController();
  
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
        ),
        Container(
          color: Colors.blue,
        ),
        Container(
          color: Colors.pink,
        ),
      ],
    );
  }
}