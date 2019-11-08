import 'package:flutter/material.dart';
import 'package:my_ecommerce_jordann/models/userModel.dart';
import 'package:scoped_model/scoped_model.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  
  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _addressController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          
          if(model.isLoading)
            return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.black),),);

          return Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(hintText: "Nome completo"),
                  keyboardType: TextInputType.text,
                  validator: (text){
                    if(text.isEmpty || !text.contains(" ")) return "Nome inválido";
                  },
                ),
              ),
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
              Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(hintText: "Endereço"),
                  keyboardType: TextInputType.text,
                  validator: (text){
                    if(text.isEmpty || !text.contains(" ")) return "Enderço inválido";
                  },
                ),
              ),
              SizedBox(height: 16,),
              SizedBox(height: 44.0,
                child: RaisedButton(
                  child: Text("Criar conta",
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  ),
                  color: primaryColor,
                  onPressed: (){
                    if(_formKey.currentState.validate()) {
                      Map<String, dynamic> userData = {
                        "name": _nameController.text,
                        "email": _emailController.text,
                        "address": _addressController.text
                      };

                      model.singUp(
                        userData: userData,
                        pass: _passController.text,
                        onSuccess: () { _onSuccess(); },
                        onFail: () { _onFail(); },
                      );
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
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Usuário criado com sucesso!"),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 2),
      )
    );

    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Falha ao criar o usuário, confira os campos e tente novamente"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      )
    );
  }
}

