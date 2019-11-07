import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  
   final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: TextFormField(
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
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: TextFormField(
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
                    
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}