import 'package:http/http.dart' as http;
import 'package:moodleapp/database/Dados_dao.dart';
import 'package:moodleapp/entitys/course.dart';
import 'package:moodleapp/entitys/dados.dart';
import 'package:moodleapp/entitys/disciplina.dart';
import 'package:moodleapp/utils/shared_var.dart';
import 'dart:convert' as convert;

class ConsultaApi {
  static var url_login = 'https://appinfor.com.br/tecnico/login/token.php';
  static var url_webservice =
      'https://appinfor.com.br/tecnico/webservice/rest/server.php';

  static Future<int> login(String username, String password) async {
    Map params = {
      'username': username,
      'password': password,
      'service': 'moodle_mobile_app'
    };
    var response = await http.post(url_login, body: params);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['token'] != null) {
        var token = jsonResponse['token'];
        await SharedVar.setToken(token);
        return 1;
      }
      return 2;
    } else {
      return 0;
    }
  }

  static Future<List<Course>> getCursosMatriculados(String token) async {
    Map params = {
      'wstoken': token,
      'moodlewsrestformat': "json",
      'wsfunction':
          'core_course_get_enrolled_courses_by_timeline_classification',
      "classification": "inprogress"
    };
    var response = await http.post(url_webservice, body: params);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var rest = jsonResponse["courses"] as List;
      List<Course> list =
          rest.map<Course>((json) => Course.fromJson(json)).toList();
      return list;
    } else {
      return null;
    }
  }

  static Future<List<Disciplina>> getDisciplina(
      String token, int idDisciplina) async {
    Map params = {
      'wstoken': token,
      'moodlewsrestformat': "json",
      'wsfunction': 'core_course_get_contents',
      "courseid": idDisciplina.toString()
    };
    var response;
    try {
      response = await http.post(url_webservice, body: params);
    } catch (_) {
      response = null;
    }
    if (response != null && response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var rest = jsonResponse as List;
      List<Disciplina> list =
          rest.map<Disciplina>((json) => Disciplina.fromJson(json)).toList();
      await atualizarDados(idDisciplina, response);
      return list;
    } else {
      Dados dado = await getDado(idDisciplina);
      if (dado != null) {
        var decode = convert.jsonDecode(dado.json);
        var rest = convert.jsonDecode(decode) as List;
        List<Disciplina> list =
            rest.map<Disciplina>((json) => Disciplina.fromJson(json)).toList();
        return list;
      }
      return null;
    }
  }

  static Future<void> atualizarDados(int idDisciplina, var response) async {
    Dados dado = await getDado(idDisciplina);
    if (dado == null) {
      Dados dado = Dados(
          json: convert.jsonEncode(response.body).toString(),
          tipo: "disciplina" + idDisciplina.toString());
      DadosDAO().save(dado);
    } else {
      dado.json = convert.jsonEncode(response.body).toString();
      DadosDAO().update(dado);
    }
  }

  static Future<Dados> getDado(int iddisciplina) async {
    print("id:" + iddisciplina.toString());
    List<Dados> dados =
        await DadosDAO().findAllByTipo("disciplina" + iddisciplina.toString());

    if (dados.length > 0) {
      return dados[0];
    } else {
      return null;
    }
  }
}
