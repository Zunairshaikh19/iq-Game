import 'player_model.dart';
import 'by_model.dart';
import 'questions.dart';

class Games {
  String? id, name, description, designedto;
  bool? premium, deleted;
  int? color, played;
  DateTime? created;
  ByModel? by;
  List<int>? categories, ageGroup;
  List<Questions>? questions;
  List<String>? search;
  List<Players>? players;
  List<DateTime>? dates;

  Games({
    this.id,
    this.name,
    this.description,
    this.by,
    this.categories,
    this.color,
    this.created,
    this.premium,
    this.questions,
    this.played,
    this.deleted,
    required this.search,
    required this.designedto,
    this.players,
    required this.ageGroup,
    this.dates,
  });

  factory Games.fromMap(var map) {
    return Games(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      categories: map['categories'].cast<int>().toList(),
      created: map['created'].toDate(),
      color: map['color'],
      premium: map['premium'],
      by: ByModel.fromMap(map['by']),
      questions:
          map['questions'].map<Questions>((e) => Questions.fromMap(e)).toList(),
      played: map['played'],
      deleted: map['deleted'],
      search: map['search'].cast<String>().toList(),
      designedto: map['designto'],
      ageGroup: map['age'].cast<int>().toList(),
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id ?? '';
    map['name'] = name ?? '';
    map['description'] = description ?? '';
    map['color'] = color ?? 000000;
    map['created'] = created ?? DateTime.now();
    map['premium'] = premium ?? false;
    if (categories == null) {
      map['categories'] = [];
    } else {
      map['categories'] = categories!.toList();
    }
    if (by == null) {
      map['by'] = ByModel().toMap();
    } else {
      map['by'] = by?.toMap();
    }
    if (questions == null) {
      map['questions'] = [];
    } else {
      map['questions'] = questions?.map((e) => e.toMap()).toList();
    }
    map['played'] = played ?? 0;
    map['deleted'] = deleted ?? false;
    if (search == null) {
      map['search'] = [];
    } else {
      map['search'] = search?.toList();
    }
    map['designto'] = designedto ?? '';
    map['age'] = ageGroup ?? [];
    return map;
  }
}
