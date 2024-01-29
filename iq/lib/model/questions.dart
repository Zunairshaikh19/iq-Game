import 'reasons.dart';
import 'by_model.dart';

class Questions {
  String? id, question;
  DateTime? date;
  ByModel? by;
  Reasons? reason;
  int? type; // 0: admin, 1: user, 2: admin questionair
  List<int>? ageGroup, categories;

  Questions({
    this.id,
    this.question,
    this.by,
    this.date,
    this.reason,
    required this.type,
    this.ageGroup,
    this.categories,
  });

  factory Questions.fromMap(var map) {
    return Questions(
      id: map['id'],
      question: map['question'],
      by: ByModel.fromMap(map['by']),
      date: map['date'].toDate(),
      reason: Reasons.fromMap(map['reason']),
      type: map['type'],
      ageGroup: map['age_group'].cast<int>().toList(),
      categories: map['categories'].cast<int>().toList(),
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id ?? '';
    map['question'] = question ?? '';
    if (by == null) {
      map['by'] = ByModel().toMap();
    } else {
      map['by'] = by?.toMap();
    }
    map['date'] = date ?? DateTime.now();
    if (reason == null) {
      map['reason'] = Reasons().toMap();
    } else {
      map['reason'] = reason?.toMap();
    }
    map['type'] = type ?? 0;
    if (categories == null) {
      map['categories'] = [0];
    } else {
      map['categories'] = categories;
    }
    if (ageGroup == null) {
      map['age_group'] = [0];
    } else {
      map['age_group'] = ageGroup;
    }
    return map;
  }
}
