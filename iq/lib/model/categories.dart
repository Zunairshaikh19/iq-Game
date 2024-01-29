import 'app_model.dart';

class Categories {
  String? id;
  List<AppModel>? categories;

  Categories({this.id, this.categories});

  factory Categories.fromMap(var map) {
    return Categories(
      id: map['id'],
      categories:
          map['categories'].map<AppModel>((e) => AppModel.category(e)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id ?? '';
    if (categories == null) {
      map['categories'] = [];
    } else {
      map['categories'] = categories?.map((e) => e.toCategories()).toList();
    }
    return map;
  }
}
