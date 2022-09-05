
import 'package:app_ordem_servico/core/model/usuario_model.dart';
import 'package:app_ordem_servico/core/persistence/open_database.dart';
import 'package:sqflite/sqflite.dart';

class UsuarioPersistence{
  static final List<Usuario> _usuarios = [];

  static const String _nomeTabela = 'usuario';
  static const String _col_idUsuario = 'idUsuario';
  static const String _col_username = 'username';
  static const String _col_password = 'password';
  static const String _col_permission = 'permission';
  static const String _col_token = 'token';

  static const String sqlDropTableIfExist = 'DROP TABLE IF EXISTS bancoUm.$_nomeTabela ';

  static const String sqlTabelaUsuario = 'CREATE TABLE $_nomeTabela ('
      '$_col_idUsuario INTEGER PRIMARY KEY, '
      '$_col_username TEXT, '
      '$_col_password TEXT, '
      '$_col_permission TEXT,'
      '$_col_token TEXT )';

  static adicionar(Usuario u) async{
    _usuarios.add(u);

    final Database db = await getDatabase();
    await db.insert(_nomeTabela, u.toJson());
  }

  static deletar() async {
    print("Método deletar");
    final Database db = await getDatabase();
    await db.delete(_nomeTabela);
  }
}