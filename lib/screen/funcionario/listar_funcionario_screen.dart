
import 'package:app_ordem_servico/core/model/funcionario_model.dart';
import 'package:app_ordem_servico/core/service/funcionario_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ListarFuncionarios extends StatefulWidget {
  const ListarFuncionarios({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<ListarFuncionarios> {

  var _carregando = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Funcionários'),
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
            await _carregarDados();
          },
          child: _montaListView(),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              child: Icon(Icons.add_outlined),
              onPressed: () async {
                Modular.to.pushNamed("add_funcionario");
              },
              heroTag: null,
            ),
            SizedBox(height: 10,),
          ],
        ),
    );
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

  _montaListView(){
    return FutureBuilder(
      future: FuncionarioService().getFuncionarios(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
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
                  " ${snapshot.data[index].cpf} "),
                onTap: () {
                  Modular.to.pushNamed("ver_funcionario", arguments: snapshot.data[index]);
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




class ItemFuncionario extends StatelessWidget {
  late final Funcionario _funcionario;
  late final Function onClick;

  ItemFuncionario(this._funcionario, {required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () => this.onClick(),
          title: Text(
            this._funcionario.nome!,
            style: TextStyle(fontSize: 24),
          ),
          subtitle: Text(
            this._funcionario.cpf!,
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