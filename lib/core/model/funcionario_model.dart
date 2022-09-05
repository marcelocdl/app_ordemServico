
import 'package:app_ordem_servico/core/model/usuario_model.dart';

class Funcionario {
    int? id_funcionario;
    String? nome;
    String? cpf;
    String? endereco;
    String? telefone;
    Usuario? usuario;

    Funcionario({
        this.id_funcionario,
        this.nome = '',
        this.cpf = '',
        this.endereco = '',
        this.telefone = '',
        this.usuario,
    });


    @override
    bool operator ==(Object other) =>
      identical(this, other) ||
      other is Funcionario &&
          runtimeType == other.runtimeType &&
          id_funcionario == other.id_funcionario &&
          nome == other.nome &&
          cpf == other.cpf &&
          endereco == other.endereco &&
          telefone == other.telefone &&
          usuario == other.usuario;


    @override
    int get hashCode =>
        id_funcionario.hashCode ^
        nome.hashCode ^
        cpf.hashCode ^
        endereco.hashCode ^
        telefone.hashCode ^
        usuario.hashCode;


    @override
    String toString() {
        return 'Funcionario{id: $id_funcionario, nome: $nome, cpf: $cpf, endereco: $endereco, telefone: $telefone, usuario: $usuario}';
    }

    Map<String, dynamic> toJson() {
        return{
            'id_funcionario': this.id_funcionario,
            'nome': this.nome,
            'numCpf': this.cpf,
            'endereco': this.endereco,
            'telefone': this.telefone,
            'usuario': this.usuario,
        };
    }

    factory Funcionario.fromMap(Map<String, dynamic> map){
        return Funcionario(
            id_funcionario: map['id_funcionario'] as int,
            nome: map['nome'],
            cpf: map['numCpf'],
            endereco: map['endereco'],
            telefone: map['telefone'],
            usuario: Usuario.fromMap(map['usuario']),
        );
    }
}