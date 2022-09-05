
import 'package:app_ordem_servico/screen/funcionario/cad_funcionario_screen.dart';
import 'package:app_ordem_servico/screen/funcionario/funcionario_detail_screen.dart';
import 'package:app_ordem_servico/screen/funcionario/listar_funcionario_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModuleFuncionario extends Module{

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => ListarFuncionarios()),
    ChildRoute('/ver_funcionario', child: (_, args) => FuncionarioDetail(tipo: args.data)),
    ChildRoute('/add_funcionario', child: (_, args) => AddFuncionario()),
  ];
}