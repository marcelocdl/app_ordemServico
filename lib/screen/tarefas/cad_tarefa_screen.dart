
import 'package:app_ordem_servico/core/model/funcionario_model.dart';
import 'package:app_ordem_servico/core/model/tarefa_model.dart';
import 'package:app_ordem_servico/core/model/usuario_model.dart';
import 'package:app_ordem_servico/core/service/funcionario_service.dart';
import 'package:app_ordem_servico/core/service/tarefa_service.dart';
import 'package:app_ordem_servico/core/service/usuario_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddTarefa extends StatefulWidget {
  const AddTarefa({Key? key}) : super (key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<AddTarefa>{

  var _carregando = false;
  late final FuncionarioService funcionarioService;


  void initState(){
    funcionarioService = FuncionarioService();
  }

  Funcionario? selecteFunc;

  TextEditingController _nome = TextEditingController();
  TextEditingController _descricao = TextEditingController();
  TextEditingController _local = TextEditingController();
  TextEditingController _encarregado = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Tarefa/Serviço'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
        children: <Widget>[
          _txtField('Nome', 'Digite o nome', _nome),
          _txtField('Descrição', 'Digite a descrição', _descricao),
          _txtField('Local', 'Digite a localização', _local),
          Row(children: [
            Text("Encarregado", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            Padding(padding: EdgeInsets.only(left: 20), child: _montaSelect(),),
          ],),
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
                  Tarefa tarefa = Tarefa();
                  tarefa.nome = _nome.text;
                  tarefa.descricao = _descricao.text;
                  tarefa.localizacao = _local.text;
                  tarefa.funcionario = selecteFunc;

                  Funcionario f = new Funcionario(
                    usuario: tarefa.funcionario?.usuario,
                    nome: tarefa.funcionario?.nome,
                    cpf: tarefa.funcionario?.cpf,
                    endereco: tarefa.funcionario?.endereco,
                    telefone: tarefa.funcionario?.telefone,
                    id_funcionario: tarefa.funcionario?.id_funcionario
                  );

                  tarefa.funcionario = f;

                  Tarefa? resp = TarefaService().cadastrarTarefa(tarefa);

                  if(resp != null){
                    Modular.to.navigate("/dashboard");
                  }else{
                    showDialog(context: context,
                      builder: (context){
                        return AlertDialog(
                            title:const Text("Erro"),
                            content: const Text("Erro ao cadastrar tarefa."),
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

  _carregarDados() async{

    setState(() {
      _carregando = true;
    });
    var funcionarioService = FuncionarioService();
    await funcionarioService.getFuncionarios();

    setState(() {
      _carregando = false;
    });
  }

  _montaSelect(){
    return FutureBuilder<List<Funcionario>>(
      future: funcionarioService.getFuncionarios(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return CircularProgressIndicator();
        }else{
          final List<Funcionario> funcs = snapshot.data!;
          return DropdownButton<Funcionario>(

              items: funcs.map(
                (f) => DropdownMenuItem(
                  child: Text(f.nome!),
                  value: f,
                ),
              ).toList(),
              onChanged: (value) => setState(() {
                selecteFunc = value;
              }),
              value: selecteFunc,
          );
        }
      },
    );
  }

}

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

Widget _buildBotaoSalvar(){
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
      child: Text('Salvar'),
      onPressed: (){
        //   new UsuarioService().login(email: 'pietra@teste', senha: '1234').then((value){
        Modular.to.pushNamed('/tarefa');
      },
    ),
  );
}