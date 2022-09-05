
import 'package:app_ordem_servico/core/model/tarefa_model.dart';
import 'package:app_ordem_servico/core/service/usuario_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/service/tarefa_service.dart';

class ListarTarefas extends StatefulWidget {
  const ListarTarefas({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<ListarTarefas> {

  var _id_usuario = UsuarioService.USUARIO_LOGADO?.idUsuario;
  var _permissao = UsuarioService.USUARIO_LOGADO?.permission;

  var _carregando = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Tarefas'),
        centerTitle: true,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10.0),
          ),
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(Icons.logout_rounded),
              onPressed: (){
                Modular.to.navigate('/');
              },
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _carregarDados(_id_usuario);
        },
        child: _montaListView(_permissao, _id_usuario),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if(_permissao == "ADMIN")
          FloatingActionButton(
            child: Icon(Icons.add_outlined),
            onPressed: () async {
              Modular.to.pushNamed("add_tarefa");
            },
            heroTag: null,
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }

  _carregarDados(int? id) async{

    setState(() {
      _carregando = true;
    });
    var tarefasService = TarefaService();
    await tarefasService.getTarefaByUserId(id);

    setState(() {
      _carregando = false;
    });
  }

  _montaListView(String? permissao, int? id){
    var future_method;

    if(permissao == 'ADMIN'){
      future_method = TarefaService().getTarefas();
    }else{
      future_method = TarefaService().getTarefaByUserId(id);
    }

    return FutureBuilder(
      future: future_method,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(!snapshot.hasData){
          return Center(
            child: Text("Não foi encontrado tarefas para você!"),
          );
        }else{
          print(snapshot);
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.lightBlueAccent,
            ),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index){
              return ListTile(
                minLeadingWidth: 10,
                leading: Text(
                  "${index + 1}",
                  style: TextStyle(fontSize: 15.0),
                ),
                title: Text(
                    " ${snapshot.data[index].nome} "),
                subtitle: Text(
                    " ${snapshot.data[index].descricao} "),
                onTap: () {
                  Modular.to.pushNamed("ver_tarefa", arguments: snapshot.data[index]);
                },

              );
            },
          );
        }
      },
    );
  }

}

Widget _Menu(){

  Function onClick;

  return PopupMenuButton(
    onSelected: (ItensMenu selecionado){
      debugPrint('Selecionado .. $selecionado');
    },
    itemBuilder: (BuildContext context) => <PopupMenuItem<ItensMenu>>[
      const PopupMenuItem(
        value: ItensMenu.Excluir,
        child: Text('Excluir'),
      )
    ],
  );
}

enum ItensMenu {Excluir}




class ItemTarefa extends StatelessWidget {
  late final Tarefa _tarefa;
  late final Function onClick;

  ItemTarefa(this._tarefa, {required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () => this.onClick(),
          title: Text(
            this._tarefa.nome!,
            style: TextStyle(fontSize: 24),
          ),
          subtitle: Text(
            this._tarefa.descricao!,
            style: TextStyle(fontSize: 12),
          ),
          trailing: _menu(context),
        ),
        Divider(
          color: Colors.lightBlueAccent,
          indent: 70.0,
          endIndent: 20,
          thickness: 1.0,
          height: 0.0,
        )
      ],
    );
  }

  Widget _menu(BuildContext context) {
    return PopupMenuButton(
      onSelected: (ItensMenuListFuncionario selecionado) {
        if (selecionado == ItensMenuListFuncionario.deletar) {

        };
      },
      itemBuilder: (BuildContext context) =>
      <PopupMenuItem<ItensMenuListFuncionario>>[
        const PopupMenuItem(
          value: ItensMenuListFuncionario.deletar,
          child: Text('Deletar'),
        ),
      ],
    );
  }
}

enum ItensMenuListFuncionario { deletar }