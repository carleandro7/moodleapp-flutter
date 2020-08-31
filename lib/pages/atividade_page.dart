import 'package:flutter/material.dart';

import 'package:moodleapp/entitys/disciplina.dart';
import 'package:moodleapp/entitys/modulo.dart';

class AtividadePage extends StatefulWidget {
  int id = -1;
  Disciplina disciplina;
  AtividadePage();
  AtividadePage.dados(this.id, this.disciplina);
  @override
  _AtividadePageState createState() => _AtividadePageState(id, disciplina);
}

class _AtividadePageState extends State<AtividadePage> {
  int id = -1;
  Disciplina disciplina;
  List<Modulo> listDados = List();
  _AtividadePageState(this.id, this.disciplina);

  @override
  void initState() {
    super.initState();
    _getAllCourses();
  }

  void _getAllCourses() async {
    List<Modulo> list = this.disciplina.listModulo;

    setState(() {
      listDados = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AtividadePage args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(this.disciplina.name),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: listDados.length,
        itemBuilder: (context, index) {
          return _courseCard(context, index);
        },
      ),
    );
  }

  Widget _courseCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Wrap(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      listDados[index].name ?? "",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        _showAtividade(context, listDados[index].id, listDados[index]);
      },
    );
  }

  void _showAtividade(BuildContext context, int index, Modulo modulo) {
    print(index);
    if (modulo.modplural == "Arquivos") {
      modulo.fileUrl;
    } else if (modulo.modplural == "Questionários") {}
  }
}
