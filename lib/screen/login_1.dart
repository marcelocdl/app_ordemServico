
//import 'dart:js';

//import 'package:app_ordem_servico/core/service/usuario_service.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
//import 'package:flutter_modular/flutter_modular.dart';

/*

import '../core/model/usuario_model.dart';

class Login extends StatelessWidget {

  TextEditingController _usuario = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'My Smart App',
        theme: ThemeData(primarySwatch: Colors.blue),

        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate
    );
  }

  Widget _buildCampoEmail(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Usuário',
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 18.0,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextField(
            controller: _usuario,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(Icons.person_outline, color: Colors.blue,),
                hintText: 'Digite seu usuário'
            ),
          ),
        )
      ],
    );
  }

  Widget _buildCampoSenha(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Senha',
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 18.0,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextField(
            controller: _password,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(Icons.lock_outline, color: Colors.blue,),
                hintText: 'Digite sua senha'
            ),
          ),
        )
      ],
    );
  }

  Widget _buildBotaoLogar(){
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder >(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              )
          ),
        ),
        child: Text('Logar'),
        onPressed: () async{
          Usuario login = Usuario();

          login.username = _usuario.text;
          login.password = _password.text;

          Usuario? user = await UsuarioService().login(login);

          print(user);
          if(user != null && user.token.isNotEmpty){
            print('Deu certo');
          }else{
            print('Errado');
          }
        },
      ),
    );
  }
}

*/