class SettingsModel {
  String? id, token;
  bool? active, notifications;
  DateTime? last;

  SettingsModel({
    this.id,
    this.active,
    this.last,
    this.notifications,
    this.token,
  });

  factory SettingsModel.fromMap(var map) {
    return SettingsModel(
      id: map['id'],
      notifications: map['notifications'],
      active: map['active'],
      last: map['last_active'].toDate(),
      token: map['token'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id ?? '';
    map['token'] = token ?? '';
    map['active'] = active ?? true;
    map['last_active'] = last ?? DateTime.now();
    map['notifications'] = notifications ?? true;
    return map;
  }
}
