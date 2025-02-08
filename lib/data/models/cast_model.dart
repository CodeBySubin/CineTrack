class Cast {
  String name;
  String profilePath;
  Cast({
    required this.name,
    required this.profilePath,
  });
  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        name: json["name"] ?? "NA",
        profilePath: json["profile_path"] ?? "NA",
      );
  Map<String, dynamic> toJson() => {
        "name": name,
        "profile_path": profilePath,
      };
}
