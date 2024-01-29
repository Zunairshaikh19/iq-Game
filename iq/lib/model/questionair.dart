import '../constants/constants.dart';
import 'reasons.dart';
import 'by_model.dart';
import 'questions.dart';

class Questionair {
  String? id, name;
  int? status; // 0: added, 1: approved, 2: disapproved
  DateTime? generated;
  List<int>? categories;
  List<Questions>? questions;
  ByModel? by;
  Reasons? reason;
  bool? added, admin;
  int? type, color; // 0: question , 1: questionair
  List<DateTime>? dates;

  Questionair({
    this.id,
    this.by,
    this.categories,
    this.generated,
    this.name,
    this.questions,
    this.reason,
    this.status,
    this.added,
    this.type,
    this.admin,
    this.color,
    this.dates,
  });

  factory Questionair.fromMap(var map) {
    return Questionair(
      id: map['id'],
      by: ByModel.fromMap(map['by']),
      categories: map['categories'].cast<int>().toList(),
      generated: map['generated'].toDate(),
      name: map['name'],
      questions:
          map['questions'].map<Questions>((e) => Questions.fromMap(e)).toList(),
      reason: Reasons.fromMap(map['reason']),
      status: map['status'],
      added: map['added'],
      type: map['type'],
      admin: map['admin'],
      color: map['color'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id ?? '';
    map['generated'] = generated ?? DateTime.now();
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
    map['name'] = name ?? '';
    if (questions == null) {
      map['questions'] = [];
    } else {
      map['questions'] = questions?.map((e) => e.toMap()).toList();
    }
    map['status'] = status ?? 0;
    if (reason == null) {
      map['reason'] = Reasons().toMap();
    } else {
      map['reason'] = reason?.toMap();
    }
    map['added'] = added ?? false;
    map['type'] = type ?? 1;
    map['admin'] = admin ?? true;
    map['color'] = color ?? AppColors.primary1.value;
    return map;
  }
}
