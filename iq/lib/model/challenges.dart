

import '../constants/constants.dart';
import 'reasons.dart';
import 'by_model.dart';
import 'questions.dart';

class Challenges {
  String? id, name;
  int? players, status; // 0: added,1: approved, 2: disapprove
  ByModel? by;
  DateTime? created;
  List<int>? categories;
  List<Questions>? questions;
  Reasons? reasons;
  bool? added, admin;
  int? color;
  List<DateTime>? dates;

  Challenges({
    this.id,
    this.name,
    this.players,
    this.by,
    this.categories,
    this.created,
    this.questions,
    this.status,
    this.reasons,
    this.added,
    this.admin,
    this.color,
    this.dates,
  });

  factory Challenges.fromMap(var map) {
    return Challenges(
      id: map['id'],
      name: map['name'],
      status: map['status'],
      created: map['created'].toDate(),
      players: map['players'],
      by: ByModel.fromMap(map['by']),
      categories: map['categories'].cast<int>().toList(),
      questions:
          map['questions'].map<Questions>((e) => Questions.fromMap(e)).toList(),
      reasons: Reasons.fromMap(map['reason']),
      added: map['added'],
      admin: map['admin'],
      color: map['color'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id ?? '';
    map['name'] = name ?? '';
    map['created'] = created ?? DateTime.now();
    map['status'] = status ?? 1;
    map['players'] = players ?? 1;
    if (by == null) {
      map['by'] = ByModel().toMap();
    } else {
      map['by'] = by?.toMap();
    }
    if (categories == null) {
      map['categories'] = [];
    } else {
      map['categories'] = categories?.toList();
    }
    if (questions == null) {
      map['questions'] = [];
    } else {
      map['questions'] = questions?.map((e) => e.toMap()).toList();
    }
    if (reasons == null) {
      map['reason'] = Reasons().toMap();
    } else {
      map['reason'] = reasons?.toMap();
    }
    map['added'] = added ?? false;
    map['admin'] = admin ?? true;
    map['color'] = color ?? AppColors.accent.value;
    return map;
  }
}
