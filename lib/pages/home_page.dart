import 'package:flutter/material.dart';
import 'package:moodleapp/entitys/course.dart';
import 'package:moodleapp/pages/diciplina_page.dart';
import 'package:moodleapp/utils/consulta_api.dart';
import 'package:moodleapp/utils/nav.dart';
import 'package:moodleapp/utils/shared_var.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Course> courses = List();
  String date;

  @override
  void initState() {
    super.initState();
    _getAllCourses();
  }

  void _getAllCourses() async {
    String token = await SharedVar.getToken();
    List<Course> list = await ConsultaApi.getCursosMatriculados(token);

    setState(() {
      courses = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Disciplinas"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: courses.length,
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
                      courses[index].fullnamedisplay ?? "",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      courses[index].coursecategory ?? "",
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        _showCourse(context, courses[index].id, courses[index].fullnamedisplay);
      },
    );
  }

  void _showCourse(BuildContext context, int index, String nomeDisciplina) {
    print(index);
    pushAndRemoveUntil(context, DisciplinaPage.dados(index, nomeDisciplina));
  }
}
