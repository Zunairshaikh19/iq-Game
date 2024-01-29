import 'app_model.dart';

class AgeGroup {
  String? id;
  List<AppModel>? group;

  AgeGroup({this.id, this.group});

  factory AgeGroup.fromMap(var map) {
    return AgeGroup(
      id: map['id'],
      group: map['group'].map<AppModel>((e) => AppModel.category(e)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id ?? '';
    if (group == null) {
      map['group'] = [];
    } else {
      map['group'] = group?.map((e) => e.toCategories()).toList();
    }
    return map;
  }
}
