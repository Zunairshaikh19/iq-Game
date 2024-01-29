class FAQ {
  String? id, question, answer;
  DateTime? created;

  FAQ({
    this.id,
    this.question,
    this.answer,
    this.created,
  });

  factory FAQ.fromMap(var map) {
    return FAQ(
      id: map['id'],
      question: map['question'],
      answer: map['answer'],
      created: map['created'].toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id ?? '';
    map['question'] = question ?? '';
    map['answer'] = answer ?? '';
    map['created'] = created ?? DateTime.now();
    return map;
  }
}
