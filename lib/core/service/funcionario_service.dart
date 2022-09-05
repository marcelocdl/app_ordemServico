
import 'dart:convert';

import 'package:app_ordem_servico/core/model/funcionario_model.dart';
import 'package:app_ordem_servico/core/service/abstract_service.dart';

class FuncionarioService extends AbstractService{

  Funcionario parseFuncionario(String responseBody) {
    final parsed = json.decode(responseBody);
    Funcionario func = Funcionario.fromMap(parsed);

    return func;
  }


  static List<Funcionario> parseFuncionarios(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    List<Funcionario> funcionarios = parsed.map<Funcionario>((json) => Funcionario.fromMap(json)).toList();
    //print(funcionarios);
    return funcionarios;
  }


  Future<List<Funcionario>> getFuncionarios() async {
    final uri =
    Uri.http(URL_API, '/funcionario/');
    final response = await  client?.get(uri,
        headers: super.headers);
    if (response?.statusCode == 200) {
      List<Funcionario> docs = parseFuncionarios(utf8.decode(response!.bodyBytes));
      return docs;
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<Funcionario> getFuncionarioById(int? id) async {
    Funcionario data;
    final uri =
    Uri.http(URL_API, '/funcionario/$id');
    final response = await  client?.get(uri,
        headers: super.headers);
    if (response?.statusCode == 200) {
      data = parseFuncionario(utf8.decode(response!.bodyBytes));

      return data;
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<bool> deletarFuncionario(int id) async {
    final uri = Uri.http(URL_API, '/funcionario/deletar/$id');
    final response = await client?.delete(uri,
    headers: super.headers);
    if(response?.statusCode == 200) {
      return true;
    }else{
      throw Exception('Falha ao deletar funcionário');
      return false;
    }
  }

  Funcionario editarFuncionario(Funcionario func) {
    int? id = func.id_funcionario;
    final uri = Uri.http(URL_API, '/funcionario/editar/$id');
    final response = client?.put(uri,
        headers: super.headers,
        body: jsonEncode(func)
    );

    print('Editar req -> '+func.toString());

    if(response != null) {
      return func;
    }else{
      throw Exception('Falha ao editar funcionário');
    }
  }

  Funcionario cadastrarFuncionario(Funcionario f){

    print(jsonEncode(f));

    final uri = Uri.http(URL_API, '/funcionario/cadastrar/');
    final response = client?.post(uri,
        headers: super.headers,
        body: jsonEncode(f)
    );
    if(response != null) {
      return f;
    }else{
      throw Exception('Falha ao editar funcionário');
    }
  }

}