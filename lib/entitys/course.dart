class Course {
  String fullnamedisplay;
  String shortname;
  bool visible;
  int progress;
  int id;
  String coursecategory;
  Course(
      {this.fullnamedisplay,
      this.shortname,
      this.visible,
      this.progress,
      this.id,
      this.coursecategory});

  factory Course.fromJson(Map<String, dynamic> parsedJson) {
    return Course(
        id: parsedJson['id'],
        fullnamedisplay: parsedJson['fullnamedisplay'],
        shortname: parsedJson['shortname'],
        progress: parsedJson['progress'],
        coursecategory: parsedJson['coursecategory'],
        visible: parsedJson['visible']);
  }
}
