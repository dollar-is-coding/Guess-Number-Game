class ResultModel {
  int? id;
  String date;
  int win;
  int lose;
  int pass;

  ResultModel({
    this.id,
    required this.date,
    required this.win,
    required this.lose,
    required this.pass,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        id: json['id'],
        date: json['date'].toString(),
        win: json['win'],
        lose: json['lose'],
        pass: json['pass'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'win': win,
        'lose': lose,
        'pass': pass,
      };
}
