
import 'package:app_ordem_servico/core/model/funcionario_model.dart';

class Tarefa {
    int? id_tarefa;
    String? nome;
    String? descricao;
    String? localizacao;
    Funcionario? funcionario;

    Tarefa({
        this.id_tarefa,
        this.nome = "",
        this.descricao = "",
        this.localizacao = "",
        this.funcionario
    });


    @override
    bool operator ==(Object other) =>
        identical(this, other) ||
        other is Tarefa &&
          runtimeType == other.runtimeType &&
          id_tarefa == other.id_tarefa &&
          nome == other.nome &&
          descricao == other.descricao &&
          localizacao == other.localizacao &&
          funcionario == other.funcionario;

    @override
    int get hashCode =>
      id_tarefa.hashCode ^
      nome.hashCode ^
      descricao.hashCode ^
      localizacao.hashCode ^
      funcionario.hashCode;

    factory Tarefa.fromJson(Map<String, dynamic> json) {
        return Tarefa(
            id_tarefa: json['id_tarefa'],
            nome: json['nome'],
            descricao: json['descricao'],
            localizacao: json['localizacao'],
            funcionario: json['funcionario'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id_tarefa'] = this.id_tarefa;
        data['nome'] = this.nome;
        data['descricao'] = this.descricao;
        data['localizacao'] = this.localizacao;
        data['funcionario'] = this.funcionario;

        return data;
    }

    factory Tarefa.fromMap(Map<String, dynamic> map){
        return Tarefa(
            id_tarefa: map['id_tarefa'] as int,
            nome: map['nome'],
            descricao: map['descricao'],
            localizacao: map['localizacao'],
            funcionario: Funcionario.fromMap(map['funcionario']),
        );
    }

    @override
  String toString() {
    return 'Tarefa{id_tarefa: $id_tarefa, nome: $nome, descricao: $descricao, localizacao: $localizacao, funcionario: $funcionario}';
  }
}