
import 'package:app_ordem_servico/core/service/usuario_service.dart';
import 'package:app_ordem_servico/screen/funcionario/listar_funcionario_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../core/model/usuario_model.dart';
import 'login_1.dart';

class Dashboard extends StatefulWidget {

  final Usuario? tipo;
  const Dashboard({Key? key, this.tipo}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<Dashboard>{

  Usuario dados = Modular.args.data;

  @override
  Widget build(BuildContext context) {

    //dados.permission = 'user';

    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard...'),
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
        body: Stack(
          children: <Widget>[
            Container(
              height: double.maxFinite,
              alignment: Alignment.center,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 120.0,
                ),
                child: Column(children: <Widget>[
                  if(dados.permission == 'ADMIN')
                  _ItemButton('Funcionários', Icons.engineering_outlined, () {
                      //Navigator.pushNamed(context, '/listar_funcionarios');
                      Modular.to.pushNamed('/funcionario');
                    }
                  ),
                  _ItemButton('Serviços/Tarefas', Icons.list_alt_outlined, () {
                      Modular.to.pushNamed('/tarefa');
                    }
                  )
                ],),
              ),
            )
        ],
      ),
    );
  }
}

class _ItemButton extends StatelessWidget {

  final String titulo;
  final IconData icone;
  final GestureTapCallback onClick;

  _ItemButton(this.titulo, this.icone, this.onClick);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        color: Colors.blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        elevation: 10.0,
        child: ElevatedButton(
          onPressed: onClick,
          child: Container(
            // color: Colors.green,
            width: 150,
            height: 80,
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(this.icone,
                  color: Colors.white,
                ),
                Text(this.titulo, style: TextStyle(
                    color: Colors.white, fontSize: 16
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }

}
