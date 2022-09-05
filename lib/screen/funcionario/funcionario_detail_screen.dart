
import 'package:app_ordem_servico/core/service/funcionario_service.dart';
import 'package:app_ordem_servico/core/service/usuario_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/model/funcionario_model.dart';
import '../../core/model/usuario_model.dart';

class FuncionarioDetail extends StatefulWidget {

  final Funcionario? tipo;
  const FuncionarioDetail({Key? key, this.tipo}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<FuncionarioDetail>{

  Funcionario dados = Modular.args.data;

  late int id_f = 0;

  TextEditingController _nome = TextEditingController();
  TextEditingController _endereco = TextEditingController();
  TextEditingController _cpf = TextEditingController();
  TextEditingController _telefone = TextEditingController();

  Usuario u =  Usuario();

  _getFuncionario() async {
    int? id = dados.id_funcionario;
    id_f = id!;
    Funcionario? func = await FuncionarioService().getFuncionarioById(id);

    _nome.text = func.nome!;
    _endereco.text = func.endereco!;
    _cpf.text = func.cpf!;
    _telefone.text = func.telefone!;

  }

  @override
  Widget build(BuildContext context) {
    _getFuncionario();

    return Scaffold(
        appBar: AppBar(
          title: Text('Detalhes Funcionários'),
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

              Wrap(
                children: [
                  if(dados.usuario != null)
                    _buildBotaoCancelar(),
                  Padding(
                      padding: EdgeInsets.all(20.0),
                      child: MaterialButton(
                        onPressed: (){
                          FuncionarioService fs = FuncionarioService();

                          Future resp;

                          if(fs.deletarFuncionario(id_f) != null){
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
                        },
                        color: Colors.redAccent,
                        child: Icon(
                          Icons.delete_outline,
                          color: Colors.white,
                          size: 42,
                        ),
                        padding: EdgeInsets.all(16),
                        shape: CircleBorder(),
                      )
                  ),
                ],
              )

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
      readOnly: true,
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
  return Padding(
    padding: EdgeInsets.all(20.0),
    child: MaterialButton(
      onPressed: (){
        Modular.to.pop();
      },
      color: Colors.blue,
      child: Icon(
        Icons.arrow_back,
        color: Colors.white,
        size: 42,
      ),
      padding: EdgeInsets.all(16),
      shape: CircleBorder(),
    )
  );
}