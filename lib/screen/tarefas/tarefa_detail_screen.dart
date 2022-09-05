
import 'package:app_ordem_servico/core/model/tarefa_model.dart';
import 'package:app_ordem_servico/core/service/funcionario_service.dart';
import 'package:app_ordem_servico/core/service/tarefa_service.dart';
import 'package:app_ordem_servico/core/service/usuario_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/model/funcionario_model.dart';
import '../../core/model/usuario_model.dart';

class TarefaDetail extends StatefulWidget {

  final Tarefa? tipo;
  const TarefaDetail({Key? key, this.tipo}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<TarefaDetail>{

  Tarefa dados = Modular.args.data;

  late int id_t = 0;

  TextEditingController _nome = TextEditingController();
  TextEditingController _descricao = TextEditingController();
  TextEditingController _localizacao = TextEditingController();
  TextEditingController _encarregado = TextEditingController();

  _getTarefa() async {
    int? id = dados.id_tarefa;
    id_t = id!;
    Tarefa? tarefa = await TarefaService().getTarefaById(id);

    String? nome_func = tarefa.funcionario?.nome;

    _nome.text = tarefa.nome!;
    _descricao.text = tarefa.descricao!;
    _localizacao.text = tarefa.localizacao!;
    _encarregado.text = nome_func!;

  }

  @override
  Widget build(BuildContext context) {
    _getTarefa();

    return Scaffold(
        appBar: AppBar(
          title: Text('Detalhes da Tarefa'),
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
              _txtField('Descrição', '', _descricao),
              _txtField('Localização', '', _localizacao),
              _txtField('Encarregado', '', _encarregado),
              _buildBotaoCancelar()
            ],
          ),)
    );
    throw UnimplementedError();
  }

  _carregarDados(int id) async{
    var tarefasService = TarefaService();
    await tarefasService.getTarefaById(id);
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