import 'package:iq/constants/constants.dart';

class UserModel {
  String? id, name, email, password, profile, bio;
  bool? premium, deleted, anonymous;
  DateTime? created;
  List<String>? search;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.created,
      this.premium,
      this.profile,
      this.deleted,
      this.search,
      this.anonymous,
      this.bio});

  factory UserModel.fromMap(var map) {
    return UserModel(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        password: map['password'],
        created: map['created'].toDate(),
        premium: map['premium'],
        profile: map['profile'],
        deleted: map['deleted'],
        search: map['search'].cast<String>().toList(),
        anonymous: map['anonymous'],
        bio: map['bio']);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id ?? '';
    map['name'] = name ?? '';
    map['email'] = email ?? '';
    map['password'] = password ?? '';
    map['profile'] = profile ?? AppIcons.logo;
    map['premium'] = premium ?? false;
    map['created'] = created ?? DateTime.now();
    map['deleted'] = deleted ?? false;
    map['bio'] = bio ?? '';
    if (search == null) {
      map['search'] = [];
    } else {
      map['search'] = search?.toList();
    }
    map['anonymous'] = anonymous ?? false;
    return map;
  }
}
