import 'package:http/http.dart' as http;

class LoginApi {

  static Future<bool> login(String login, String senha) async {
    var url = 'http://livrowebservices.com.br/rest/login';

    Map body = {
      'login' : login,
      'senha' : senha
    };

    var response = await http.post(url, body: body);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return true;
  }

}