
import 'package:app_ordem_servico/screen/dashboard.dart';
import 'package:app_ordem_servico/screen/funcionario/app_module_funcionario.dart';
import 'package:app_ordem_servico/screen/login_1.dart';
import 'package:app_ordem_servico/screen/tarefas/app_module_tarefa.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'login.dart';


class AppModule extends Module{

  @override
  List<ModularRoute> get routes =>[
    ChildRoute('/', child: (context, args) => Iniciar()),
    //ChildRoute('/dashboard', child: (context, args) => Dashboard()),
    ChildRoute('/dashboard', child: (_, args) => Dashboard(tipo: args.data)),
    ModuleRoute('/funcionario', module: AppModuleFuncionario()),
    ModuleRoute('/tarefa', module: AppModuleTarefa()),
  ];
}