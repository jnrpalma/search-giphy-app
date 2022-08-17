import 'dart:io';

class MyHtppOverride extends HttpOverrides{
@override
  HttpClient createHttpClient(SecurityContext? context) {
    
    final httpClient =  super.createHttpClient(context);
    httpClient.badCertificateCallback = (cert, host, port) { //metodo: para validar o certificado
      return true;
    };
    return httpClient;
  }
}