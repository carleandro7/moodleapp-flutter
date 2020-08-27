import 'package:flutter/material.dart';
import 'package:moodleapp/pages/home_page.dart';
import 'Dart:async';
import 'package:moodleapp/pages/login_page.dart';
import 'package:moodleapp/utils/consulta_api.dart';
import 'package:moodleapp/utils/nav.dart';
import 'package:moodleapp/utils/shared_var.dart';

class SpashPage extends StatefulWidget {
  @override
  _SpashPage createState() => _SpashPage();
}

class _SpashPage extends State<SpashPage> with SingleTickerProviderStateMixin {
  void handleTimeoutLogin() {
    pushAndRemoveUntil(context, LoginPage());
  }

  void handleTimeoutDisciplina() {
    pushAndRemoveUntil(context, HomePage());
  }

  startTimeoutDisciplinas() async {
    var duration = const Duration(seconds: 3);
    return new Timer(duration, handleTimeoutDisciplina);
  }

  startTimeoutLogin() async {
    var duration = const Duration(seconds: 3);
    return new Timer(duration, handleTimeoutLogin);
  }

  verificarTipoTela() async {
    String token = await SharedVar.getToken();
    if (token == "") {
      startTimeoutLogin();
    } else {
      startTimeoutDisciplinas();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verificarTipoTela();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return new Center(
      child: new Image.asset('images/logo.png'),
    );
  }
}
