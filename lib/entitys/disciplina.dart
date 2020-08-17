import 'package:moodleapp/entitys/modulo.dart';

class Disciplina {
  String name;
  int visible;
  bool uservisible;
  int id;
  List<Modulo> listModulo;

  Disciplina(
      {this.name, this.visible, this.id, this.uservisible, this.listModulo});

  factory Disciplina.fromJson(Map<String, dynamic> parsedJson) {
    var rest = parsedJson["modules"] as List;
    List<Modulo> list =
        rest.map<Modulo>((json) => Modulo.fromJson(json)).toList();
    return Disciplina(
      id: parsedJson['id'],
      name: parsedJson['name'],
      visible: parsedJson['visible'],
      uservisible: parsedJson['uservisible'],
      listModulo: list,
    );
  }
}
