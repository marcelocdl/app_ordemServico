
import 'package:app_ordem_servico/core/service/funcionario_service.dart';
import 'package:app_ordem_servico/core/service/usuario_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/model/funcionario_model.dart';
import '../../core/model/usuario_model.dart';

class AddFuncionario extends StatefulWidget {

  const AddFuncionario({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<AddFuncionario>{

  TextEditingController _nome = TextEditingController();
  TextEditingController _endereco = TextEditingController();
  TextEditingController _cpf = TextEditingController();
  TextEditingController _telefone = TextEditingController();
  TextEditingController _login = TextEditingController();
  TextEditingController _senha = TextEditingController();

  Usuario u =  Usuario();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Funcionário'),
        actions: <Widget>[
          InkWell(
            onTap: (){
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 25, left: 25),
              child: Icon(Icons.exit_to_app),
            ),
          )
        ],
      ),
      body: Padding( 
        padding: EdgeInsets.only(left: 10.0, top: 10.0),
        child: Column(
        children: <Widget>[
          _txtField('Nome', 'Digite o nome', _nome),
          _txtField('Endereço', 'Digite o endereço', _endereco),
          _txtField('CPF', 'Digite o número de CPF', _cpf),
          _txtField('Telefone', 'Digite o número para contato', _telefone),
          _txtField('Usuário', 'Digite o usuário do funcionário', _login),
          TextFormField(
            obscureText: true,
            controller: _senha,
            decoration: InputDecoration(
              hintText: 'Digite a senha do funcionário',
              labelText: 'Senha',
              labelStyle: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
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
              child: Text('Salvar'),
              onPressed: (){
                Funcionario func = Funcionario();
                func.nome = _nome.text;
                func.endereco = _endereco.text;
                func.cpf = _cpf.text;
                func.telefone = _telefone.text;

                u.username = _login.text;
                u.password = _senha.text;
                u.permission = "USER";

                func.usuario = u;

                Funcionario? resp = FuncionarioService().cadastrarFuncionario(func);

                if(resp != null){
                  Modular.to.navigate("/dashboard/");
                }else{
                  showDialog(context: context,
                    builder: (context){
                      return AlertDialog(
                        title:const Text("Erro"),
                        content: const Text("Erro ao cadastrar funcionário."),
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
                }
              }
            ),
          ),
        ],
      ),)
    );
    throw UnimplementedError();
  }

  _carregarDados(int id) async{
    var funcionarioService = FuncionarioService();
    await funcionarioService.getFuncionarioById(id);
    var dados = funcionarioService.getFuncionarioById(id);
    print("Dados -> "+dados.toString());
  }

}

/*class _txtField extends StatelessWidget {

  final String titulo;
  final String hint;

  _txtField(this.titulo, this.hint);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            this.titulo,
              style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 18.0,
              fontWeight: FontWeight.bold
            ),
          ),

          Container(
            alignment: Alignment.centerLeft,
            child: TextField(
              style: TextStyle(fontSize: 20.0),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
              hintText: this.hint
              ),
            ),
          )
        ],
    );
  }
}*/

class _txtField extends StatelessWidget {

  String titulo;
  String hint;
  TextEditingController text;

  _txtField(this.titulo, this.hint, this.text);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: text,
      decoration: InputDecoration(
        hintText: hint,
        labelText: titulo,
        labelStyle: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)
      ),
    );
  }
}

Widget _buildBotaoCancelar(){
  return MaterialButton(
    onPressed: (){
      Modular.to.navigate("/funcionario/");
    },
    color: Colors.redAccent,
    child: Icon(
      Icons.cancel_outlined,
      color: Colors.white,
      size: 42,
    ),
    padding: EdgeInsets.all(16),
    shape: CircleBorder(),
  );
}