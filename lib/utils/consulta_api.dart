import 'package:http/http.dart' as http;
import 'package:moodleapp/entitys/course.dart';
import 'package:moodleapp/entitys/disciplina.dart';
import 'package:moodleapp/pages/diciplina_page.dart';
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

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
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("tokenAluno", token);
        return 1;
      }
      return 2;
    } else {
      return 0;
    }
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('tokenAluno') ?? "";
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

  static Future<List<Disciplina>> getDisciplina(String token, int id) async {
    Map params = {
      'wstoken': token,
      'moodlewsrestformat': "json",
      'wsfunction': 'core_course_get_contents',
      "courseid": id.toString()
    };
    var response = await http.post(url_webservice, body: params);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var rest = jsonResponse as List;
      List<Disciplina> list =
          rest.map<Disciplina>((json) => Disciplina.fromJson(json)).toList();
      return list;
    } else {
      return null;
    }
  }
}
