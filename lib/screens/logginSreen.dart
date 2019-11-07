import 'package:flutter/material.dart';
import 'package:my_ecommerce_jordann/models/userModel.dart';
import 'package:my_ecommerce_jordann/screens/registerSreen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatelessWidget {
  
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text("Criar Conta!",
              style: TextStyle(fontSize: 15.0),
            ),
            textColor: Colors.white,
            onPressed: (){
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => RegisterScreen())
              );
            },
          )
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if(model.isLoading) {
            return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.black),),);
          }

          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "E-mail"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text){
                      if(text.isEmpty || !text.contains("@")) return "E-mail inválido";
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "Senha"),
                    obscureText: true,
                    validator: (text){
                      if(text.isEmpty || text.length < 6) return "Senha inválida";
                    },
                  ),
                ),
                Align(alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: (){},
                    child: Text("Esqueci minha senha",
                      textAlign: TextAlign.right,
                      style: TextStyle(color: primaryColor),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
                SizedBox(height: 16,),
                SizedBox(height: 44.0,
                  child: RaisedButton(
                    child: Text("Entrar",
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                    ),
                    color: primaryColor,
                    onPressed: (){
                      if(_formKey.currentState.validate()) {
                        model.singIn();
                      }
                    },
                  ),
                )
              ],
            ),
          );
        },
      )
    );
  }
}