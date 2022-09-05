import 'package:app_ordem_servico/screen/tarefas/cad_tarefa_screen.dart';
import 'package:app_ordem_servico/screen/tarefas/listar_tarefas_screen.dart';
import 'package:app_ordem_servico/screen/tarefas/tarefa_detail_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModuleTarefa extends Module{

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => ListarTarefas()),
    ChildRoute('/ver_tarefa', child: (_, args) => TarefaDetail(tipo: args.data)),
    ChildRoute('/add_tarefa', child: (context, args) => AddTarefa())
  ];
}