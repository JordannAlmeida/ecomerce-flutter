import 'package:flutter/material.dart';
import 'package:my_ecommerce_jordann/models/userModel.dart';
import 'package:my_ecommerce_jordann/screens/home.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: UserModel(),
      child: MaterialApp(
          title: "Ecommerce Jordann",
          theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Color.fromARGB(255, 4, 125, 141)
          ),
          home: HomePage(),
          debugShowCheckedModeBanner: false,
      ),
    );
  }
}
