class AdminModel {
  String? id, name, email, password, profile;
  DateTime? created;
  bool? deleted;

  AdminModel({
    this.id,
    this.name,
    this.email,
    this.profile,
    this.created,
    this.password,
    this.deleted,
  });

  factory AdminModel.fromMap(var map) {
    return AdminModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      profile: map['profile'],
      created: map['created'].toDate(),
      password: map['password'],
      deleted: map['deleted'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id ?? '';
    map['email'] = email ?? '';
    map['profile'] = profile ?? '';
    map['created'] = created ?? DateTime.now();
    map['password'] = password ?? '';
    map['name'] = name ?? '';
    map['deleted'] = deleted ?? false;
    return map;
  }
}
