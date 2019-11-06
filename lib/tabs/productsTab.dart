import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_ecommerce_jordann/tiles/categoryTile.dart';

class ProductsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("produtos").getDocuments(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.black
              ),
            ),
          );
        } else {
          List<Widget> widgesTiles = snapshot.data.documents.map((data) {
                return CategoryTile(data);
              }).toList();
          List<Widget> divideTiles = ListTile.divideTiles(context: context, tiles: widgesTiles, color: Colors.grey[500]).toList();

          return ListView(
            children: divideTiles
          );
        }
      },
    );
  }
}
