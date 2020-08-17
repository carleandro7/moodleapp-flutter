class Modulo {
  int id;
  String url;
  String name;
  int instance;
  int visible;
  bool uservisible;
  String modname;
  String modplural;
  String fileUrl;
  String fileName;

  Modulo(
      {this.id,
      this.url,
      this.name,
      this.instance,
      this.visible,
      this.uservisible,
      this.modname,
      this.modplural,
      this.fileName,
      this.fileUrl});

  factory Modulo.fromJson(Map<String, dynamic> parsedJson) {
    String fileNameAux = "", fileUrlAux = "";
    if (parsedJson['modplural'] == "Arquivos") {
      fileNameAux = parsedJson['contents'][0]['filename'];
      fileUrlAux = parsedJson['contents'][0]['fileurl'];
    }
    return Modulo(
      id: parsedJson['id'],
      url: parsedJson['url'],
      name: parsedJson['name'],
      instance: parsedJson['instance'],
      visible: parsedJson['visible'],
      uservisible: parsedJson['uservisible'],
      modname: parsedJson['modname'],
      modplural: parsedJson['modplural'],
      fileUrl: fileUrlAux,
      fileName: fileNameAux,
    );
  }
}
