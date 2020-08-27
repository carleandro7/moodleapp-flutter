# MoodleApp - Flutter
Aplicação desenvolvida utilizando o Flutter para o framework Moodle.
O objetivo dessa aplicação é possíbilitar o aluno acessar as disciplina e o seu conteúdo, permitindo visualizar e responder os quiz.

Versão
* Flutter 1.20.2 • channel stable • https://github.com/flutter/flutter.git
* Dart 2.9.1
* Moodle 3.8

### Consultas ao webservice do moodle

```sh
moodle_mobile_app //retorna o token
core_course_get_courses_by_field // lista as disciplinas
core_course_get_contents  //lista o conteudo dos cursos
core_course_get_enrolled_courses_by_timeline_classification //lista o cursos matriculados
```