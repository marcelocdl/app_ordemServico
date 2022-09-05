
import 'package:app_ordem_servico/core/service/usuario_service.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class AuthInterceptor implements InterceptorContract{

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async{

    if(UsuarioService.USUARIO_LOGADO != null){
      data.headers['authorization'] = 'Bearer ' + UsuarioService.USUARIO_LOGADO!.token;

    }else{
      print('********** requisição sem usuário logado **********');
    }
    return data;

  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async{
    return data;
  }
}