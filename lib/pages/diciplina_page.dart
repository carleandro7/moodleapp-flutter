import 'package:flutter/material.dart';

import 'package:moodleapp/entitys/disciplina.dart';
import 'package:moodleapp/utils/consulta_api.dart';

class DisciplinaPage extends StatefulWidget {
  int id = -1;
  String disciplinaNome;
  DisciplinaPage();
  DisciplinaPage.dados(this.id, this.disciplinaNome);
  @override
  _DisciplinaPageState createState() =>
      _DisciplinaPageState(id, disciplinaNome);
}

class _DisciplinaPageState extends State<DisciplinaPage> {
  int id = -1;
  String disciplinaNome;
  List<Disciplina> listDados = List();
  _DisciplinaPageState(this.id, this.disciplinaNome);
  @override
  void initState() {
    super.initState();
    _getAllCourses();
  }

  void _getAllCourses() async {
    String token = await ConsultaApi.getToken();
    List<Disciplina> list = await ConsultaApi.getDisciplina(token, id);

    setState(() {
      listDados = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    final DisciplinaPage args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(this.disciplinaNome),
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
      onTap: () {},
    );
  }
}
