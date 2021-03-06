import 'package:flutter/material.dart';
import 'package:my_ecommerce_jordann/models/userModel.dart';
import 'package:my_ecommerce_jordann/screens/logginSreen.dart';
import 'package:my_ecommerce_jordann/tiles/drawerTile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  
  final PageController pageController;

  CustomDrawer(this.pageController);
  
  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB( 255, 203, 236, 241),
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        )
      ),
    );
    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 10.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text("Ecommerce\nJordann",
                        style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model) {
                          String nameUser = model.userData["name"];
                          String helloUser = model.isLoggedin() ? "Olá $nameUser" : "Olá";
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(helloUser, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                              GestureDetector(
                                child: Text(model.isLoggedin() ? "sair" : "Entre ou cadastre-se", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16.0, fontWeight:  FontWeight.bold)),
                                onTap: (){
                                  if(model.isLoggedin()) {
                                    model.singOut();
                                  } else{
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                                  }
                                },
                              )
                            ],
                          );
                        },
                      )
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Início", pageController, 0),
              DrawerTile(Icons.list, "Produtos", pageController, 1),
              DrawerTile(Icons.location_on, "Lojas", pageController, 2),
              DrawerTile(Icons.playlist_add_check, "Menu Pedidos", pageController, 3),
            ],
          )
        ],
      ),
    );
  }
}