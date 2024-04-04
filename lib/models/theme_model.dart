class ThemeModel {
  int? id;
  int isLight;

  ThemeModel({
    this.id,
    required this.isLight,
  });

  factory ThemeModel.fromJson(Map<String, dynamic> json) => ThemeModel(
        id: json['id'],
        isLight: json['isLight'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'isLight': isLight,
      };
}
