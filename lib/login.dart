
import 'package:app_ordem_servico/core/model/usuario_model.dart';
import 'package:app_ordem_servico/core/service/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sqflite/sqflite.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Ordem e Serviço',
        theme: ThemeData(primarySwatch: Colors.blue),

        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate
    );
  }
}

class Iniciar extends StatelessWidget {
  const Iniciar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _username = TextEditingController();
    TextEditingController _password = TextEditingController();

    return  Scaffold(
      appBar: AppBar(
        title:const  Text("Login"),
      ),
      body: Container(
          padding: const  EdgeInsets.symmetric(vertical: 50.0),

          width: double.infinity,
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  ),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _username,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Usuário',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextField(
                  obscureText: true,
                  controller: _password,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Senha',
                  ),
                ),


              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () async{
                      Usuario login = Usuario();

                      login.username = _username.text;
                      login.password = _password.text;

                      Usuario? user = await UsuarioService().login(login);

                      if(user != null && user.token.isNotEmpty){
                        Modular.to.navigate('dashboard', arguments: user);
                      }else{
                        showDialog(context: context,
                          builder: (context){
                            return AlertDialog(
                                title:const Text("Erro"),
                                content: const Text("Login e/ou Senha inválido(s)"),
                                actions : <Widget>[
                                  TextButton(
                                      child: const Text("OK"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }
                                  )
                                ]
                            );
                          },
                        );

                      };
                    },
                  )
              ),
            ],
          )

      ),
    );
  }
}






