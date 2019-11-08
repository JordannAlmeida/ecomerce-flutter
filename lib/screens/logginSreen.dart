import 'package:flutter/material.dart';
import 'package:my_ecommerce_jordann/models/userModel.dart';
import 'package:my_ecommerce_jordann/screens/registerSreen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      key: _scaffoldKey,
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
                    controller: _emailController,
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
                    controller: _passController,
                    decoration: InputDecoration(hintText: "Senha"),
                    obscureText: true,
                    validator: (text){
                      if(text.isEmpty || text.length < 6) return "Senha inválida";
                    },
                  ),
                ),
                Align(alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: (){
                      if(_emailController.text.isEmpty) {
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Insira seu e-mail para verificação"),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 2),
                          )
                        );
                      } else {
                        model.recoverPass(_emailController.text);
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Confira a caixa de entrada do seu email"),
                            backgroundColor: Theme.of(context).primaryColor,
                            duration: Duration(seconds: 3),
                          )
                        );
                      }
                    },
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
                        model.singIn(email: _emailController.text, pass: _passController.text, onSuccess: (){ _onSuccess(); }, onFail: (){ _onFail(); });
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

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Usuário ou senha inválidos"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      )
    );
  }
}