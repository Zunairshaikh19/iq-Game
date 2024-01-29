import 'package:flutter/material.dart';

class AppModel {
  String title;
  int value;
  String? image, subtitle, amount, id;
  IconData? icon;
  VoidCallback? ontap;
  int? duration;
  bool? extra;

  AppModel(
    this.title,
    this.value, {
    this.image,
    this.subtitle,
    this.amount,
    this.icon,
    this.ontap,
    this.id,
    this.duration,
    this.extra,
  });

  factory AppModel.category(var map) {
    return AppModel(map['title'], map['value']);
  }

  Map<String, dynamic> toCategories() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['title'] = title;
    map['value'] = value;
    return map;
  }
}

class AppSupport {
  String? id, support, privacy, terms;
  int? users, games, requests, premium, visits;

  AppSupport({
    this.id,
    this.privacy,
    this.support,
    this.terms,
    this.games,
    this.premium,
    this.requests,
    this.users,
    this.visits,
  });

  factory AppSupport.fromMap(var map) {
    return AppSupport(
      id: map['id'],
      privacy: map['privacy'],
      support: map['support'],
      terms: map['terms'],
      users: map['users'],
      games: map['games'],
      requests: map['requests'],
      premium: map['premium'],
      visits: map['visits'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id ?? '';
    map['privacy'] = privacy ?? '';
    map['support'] = support ?? '';
    map['terms'] = terms ?? '';
    map['users'] = users ?? 0;
    map['games'] = games ?? 0;
    map['requests'] = requests ?? 0;
    map['premium'] = premium ?? 0;
    map['visits'] = visits ?? 0;
    return map;
  }
}

class AboutModel {
  String? id, name, about, email;

  AboutModel({
    this.id,
    this.name,
    this.about,
    this.email,
  });

  factory AboutModel.fromMap(var map) {
    return AboutModel(
      id: map['id'],
      name: map['name'],
      about: map['about'],
      email: map['email'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id ?? '';
    map['name'] = name ?? '';
    map['about'] = about ?? '';
    map['email'] = email ?? '';
    return map;
  }
}
