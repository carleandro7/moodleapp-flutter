import 'package:flutter/material.dart';
import 'package:moodleapp/pages/home_page.dart';
import 'package:moodleapp/utils/Messages.dart';
import 'package:moodleapp/utils/consulta_api.dart';
import 'package:moodleapp/utils/nav.dart';

class LoginPage extends StatelessWidget {
  final textUsername = TextEditingController();
  final textPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Acessar"),
        centerTitle: true,
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          Image.asset('images/logo.png'),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(hintText: 'Identificação de usuário'),
            controller: textUsername,
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(hintText: 'Senha'),
            controller: textPassword,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 46,
            child: RaisedButton(
              color: Colors.green,
              child: Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              onPressed: () {
                _onClickLogin(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onClickLogin(context) async {
    int resp = await ConsultaApi.login(textUsername.text, textPassword.text);
    if (resp == 1) {
      pushAndRemoveUntil(context, HomePage());
    } else {
      Messages().msgErro("Usuário ou Senha Incorreto!", context);
    }
  }

  void _verificarUsuario(context) async {
    String token = await ConsultaApi.getToken();
    print("token:" + token);
    if (token == "") {
    } else {
      pushAndRemoveUntil(context, HomePage());
    }
  }
}
