import 'package:moodleapp/database/Dados_dao.dart';
import 'package:moodleapp/entitys/dados.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedVar {
  static Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("tokenAluno", token);
  }

  static Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('tokenAluno') ?? "";
  }

  static Future<void> setDisciplina(
      String jsonConteudo, int idDisciplina) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final dao = DadosDAO();
    var dados = Dados(
        json: ("disciplina" + idDisciplina.toString()), tipo: jsonConteudo);
    dao.save(dados);
    print(dados);
    prefs.setString("disciplina" + idDisciplina.toString(), jsonConteudo);
  }

  static Future<String> getDisciplina(int idDisciplina) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("disciplina" + idDisciplina.toString()) ?? "";
  }
}
