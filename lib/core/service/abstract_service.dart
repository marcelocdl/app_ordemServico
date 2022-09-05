
import 'package:app_ordem_servico/core/security/auth_interceptor.dart';
import 'package:app_ordem_servico/core/service/usuario_service.dart';
import 'package:http_interceptor/http/http.dart';

class AbstractService {

  InterceptedClient? client;

  AbstractService(){
    client = InterceptedClient.build(interceptors: [
      AuthInterceptor()
    ]);
  }

  //final String URL_API = "192.168.0.22:8080";
  final String URL_API = "192.168.77.36:8080";


  Map<String, String> headers = <String, String>{
    'X-usuario' : UsuarioService.USUARIO_LOGADO!.idUsuario.toString(),
    'Content-type': 'application/json; charset=utf-8',
  };


}