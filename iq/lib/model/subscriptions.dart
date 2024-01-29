class Subscriptions {
  String? id;
  DateTime? generated, cancelled;
  bool? ongoing;

  Subscriptions({
    this.id,
    this.generated,
    this.cancelled,
    this.ongoing,
  });

  factory Subscriptions.fromMap(var map) {
    return Subscriptions(
      id: map['id'],
      generated: map['generated'].toDate(),
      cancelled: map['cancelled'].toDate(),
      ongoing: map['ongoing'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id ?? '';
    map['generated'] = generated ?? DateTime.now();
    map['cancelled'] = cancelled ?? DateTime.now();
    map['ongoing'] = ongoing ?? true;
    return map;
  }
}
