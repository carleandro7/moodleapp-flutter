class Dados {
  int id;
  String json;
  String tipo;

  Dados({this.id, this.json, this.tipo});

  factory Dados.fromJson(Map<String, dynamic> parsedJson) {
    return Dados(
        id: parsedJson['id'],
        json: parsedJson['json'],
        tipo: parsedJson['tipo']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tipo'] = this.tipo;
    data['json'] = this.json;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {'id': this.id, 'json': this.json, 'tipo': this.tipo};
  }
}
