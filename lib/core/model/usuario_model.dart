
class Usuario {
    int? idUsuario;
    String? username;
    String? password;
    String? permission;
    String token = '';


    Usuario({
        this.idUsuario,
        this.username = '',
        this.password = '',
        this.permission = '',
        this.token = ''
    });


    @override
    bool operator ==(Object other) =>
        identical(this, other) ||
            other is Usuario && runtimeType == other.runtimeType &&
                idUsuario == other.idUsuario && username == other.username &&
                password == other.password && permission == other.permission &&
                token == other.token;

    @override
    int get hashCode =>
        idUsuario.hashCode ^ username.hashCode ^ password.hashCode ^ permission
            .hashCode ^ token.hashCode;


    @override
    String toString() {
        return 'Usuario{idUsuario: $idUsuario, username: $username, password: $password, permission: $permission, token: $token}';
    }

    Map<String, dynamic> toJson() {
        return {
            'idUsuario': this.idUsuario,
            'username': this.username,
            'password': this.password,
            'permission': this.permission,
            'token': this.token,
        };
    }

    factory Usuario.fromMap(Map<String, dynamic> map){
        return Usuario(
            idUsuario: map['idUsuario'] as int,
            username: map['username'],
            permission: map['permission'],
            token: map['token'] ?? ''
        );
    }

}