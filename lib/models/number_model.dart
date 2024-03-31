class NumberModel {
  int? id;
  int numberA;
  int numberB;
  int numberC;
  int numberD;
  int rightNumber;
  int rightPosition;
  int isShow;
  String correctNumber;

  NumberModel({
    this.id,
    required this.numberA,
    required this.numberB,
    required this.numberC,
    required this.numberD,
    required this.rightNumber,
    required this.rightPosition,
    required this.isShow,
    required this.correctNumber,
  });

  factory NumberModel.fromJson(Map<String, dynamic> json) => NumberModel(
        id: json['id'],
        numberA: json['numberA'],
        numberB: json['numberB'],
        numberC: json['numberC'],
        numberD: json['numberD'],
        rightNumber: json['rightNumber'],
        rightPosition: json['rightPosition'],
        isShow: json['isShow'],
        correctNumber: json['correctNumber'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'numberA': numberA,
        'numberB': numberB,
        'numberC': numberC,
        'numberD': numberD,
        'rightNumber': rightNumber,
        'rightPosition': rightPosition,
        'isShow': isShow,
        'correctNumber': correctNumber,
      };
}