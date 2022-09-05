
import 'dart:convert';

import 'package:app_ordem_servico/core/model/funcionario_model.dart';
import 'package:app_ordem_servico/core/model/tarefa_model.dart';
import 'package:app_ordem_servico/core/service/abstract_service.dart';
import 'package:app_ordem_servico/core/service/funcionario_service.dart';

class TarefaService extends AbstractService{

  Tarefa parseTarefa(String responseBody) {
    final parsed = json.decode(responseBody);
    Tarefa tar = Tarefa.fromMap(parsed);

    return tar;
  }


  static List<Tarefa> parseTarefas(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    List<Tarefa> tarefas = parsed.map<Tarefa>((json) => Tarefa.fromMap(json)).toList();
    //print(funcionarios);
    return tarefas;
  }


  Future<List<Tarefa>> getTarefas() async {
    final uri =
    Uri.http(URL_API, '/tarefa/');
    final response = await  client?.get(uri,
        headers: super.headers);
    if (response?.statusCode == 200) {
      List<Tarefa> docs = parseTarefas(utf8.decode(response!.bodyBytes));
      return docs;
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<Tarefa> getTarefaById(int? id) async {
    Tarefa data;
    final uri =
    Uri.http(URL_API, '/tarefa/$id');
    final response = await  client?.get(uri,
        headers: super.headers);
    if (response?.statusCode == 200) {
      data = parseTarefa(utf8.decode(response!.bodyBytes));

      return data;
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<bool> deletarTarefa(int id) async {
    final uri = Uri.http(URL_API, '/tarefa/deletar/$id');
    final response = await client?.delete(uri,
        headers: super.headers);
    if(response?.statusCode == 200) {
      return true;
    }else{
      throw Exception('Falha ao deletar tarefa');
      return false;
    }
  }

  Tarefa editarTarefa(Tarefa tarefa) {
    int? id = tarefa.id_tarefa;
    final uri = Uri.http(URL_API, '/tarefa/editar/$id');
    final response = client?.put(uri,
        headers: super.headers,
        body: jsonEncode(tarefa)
    );

    print('Editar req -> '+tarefa.toString());

    if(response != null) {
      return tarefa;
    }else{
      throw Exception('Falha ao editar tarefa');
    }
  }

  Tarefa cadastrarTarefa(Tarefa t){

    print(jsonEncode(t));

    final uri = Uri.http(URL_API, '/tarefa/cadastrar/');
    final response = client?.post(uri,
        headers: super.headers,
        body: jsonEncode(t)
    );
    if(response != null) {
      return t;
    }else{
      throw Exception('Falha ao cadastrar tarefa');
    }
  }

  Future<List<Tarefa>> getTarefaByUserId(int? id) async {
    final uri =
    Uri.http(URL_API, '/tarefa/tarefa_funcionario/$id');
    final response = await  client?.get(uri,
        headers: super.headers);
    if (response?.statusCode == 200) {
      List<Tarefa> docs = parseTarefas(utf8.decode(response!.bodyBytes));
      return docs;
    } else {
      throw Exception('Failed to load post');
    }
  }

}