
import 'dart:convert';
import 'package:app_ordem_servico/core/persistence/usuario_persistence.dart';


import 'package:app_ordem_servico/core/model/usuario_model.dart';
import 'package:http/http.dart';

import 'abstract_service.dart';


class UsuarioService extends AbstractService{
  static Usuario? USUARIO_LOGADO = Usuario();

  Usuario parseUsuario(String responseBody) {

    final parsed = json.decode(responseBody);
    print('parse ok -> '+responseBody.toString());
    Usuario user = Usuario.fromMap(parsed);
    USUARIO_LOGADO = user;
    print('frommap ok ');
    return user;
  }

  Future<Usuario?> login(Usuario user) async {
    try{
      USUARIO_LOGADO?.idUsuario = 0;
      final uri = Uri.http(URL_API, '/login');
      final response = await post(uri,
          headers: <String, String>{
            "Content-Type": "application/json"
          },
          body: jsonEncode(user)
      );

      if (response.statusCode == 200) {
        UsuarioPersistence.deletar();
        Usuario u = parseUsuario(response.body);
        UsuarioPersistence.adicionar(u);
        return u;

      } else if (response.statusCode == 400) {
        user.token = '';
        print('Status 400');
        return user;

      } else {
        return null;
      }

    }catch(e){
      print(e);
      return null;
    }
  }

  Future<Usuario> getUsuarioById(int? id) async {
    Usuario data;
    final uri =
    Uri.http(URL_API, '/usuario/$id');
    final response = await client?.get(uri,
        headers: super.headers);
    if (response?.statusCode == 200) {
      data = parseUsuario(utf8.decode(response!.bodyBytes));

      return data;
    } else {
      throw Exception('Failed to load post');
    }
  }

}