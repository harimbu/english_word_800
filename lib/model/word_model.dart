class WordModel {
  WordModel({
    required this.id,
    required this.title,
    required this.kor,
    required this.eng,
    required this.done,
    required this.showing,
    required this.adding,
  });

  int id;
  String title;
  String kor;
  String eng;
  int done;
  int showing;
  int adding;

  factory WordModel.fromJson(Map<String, dynamic> json) => WordModel(
        id: json["id"],
        title: json["title"],
        kor: json["kor"],
        eng: json["eng"],
        done: json["done"],
        showing: json["showing"],
        adding: json["adding"],
      );
}
