class ByModel {
  String? name, profile;

  ByModel({this.name, this.profile});

  factory ByModel.fromMap(var map) {
    return ByModel(name: map['name'], profile: map['profile']);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['name'] = name ?? '';
    map['profile'] = profile ?? '';
    return map;
  }
}
