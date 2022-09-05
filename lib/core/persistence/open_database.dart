import 'package:path/path.dart';
import 'package:app_ordem_servico/core/persistence/usuario_persistence.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async{

  return openDatabase( join(await getDatabasesPath(), 'bancoUm.db'),
      onCreate: (db, version) async{

        List<String> querys = [
          UsuarioPersistence.sqlDropTableIfExist,
          UsuarioPersistence.sqlTabelaUsuario,
        ];

        for(String sql in querys){
          print('sql: '+sql);
          db.execute(sql);
        }

      },version: 6);
}