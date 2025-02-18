

class LinkModel {
  String key;
  String site;

  LinkModel({
    required this.key,
    required this.site,
  });

  factory LinkModel.fromJson(Map<String, dynamic> json) => LinkModel(
        key: json["key"]??"",
        site: json["site"]??"",
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "site": site,
      };
}
