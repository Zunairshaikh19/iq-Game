class Players {
  String? name;
  int? age;

  Players({this.name, this.age});

  factory Players.fromMap(var map) {
    return Players(
      name: map['name'],
      age: map['age'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['name'] = name ?? '';
    map['age'] = age ?? '';
    return map;
  }
}
