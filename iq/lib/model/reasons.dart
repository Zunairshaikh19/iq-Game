class Reasons {
  String? designedto, liked, submitted, challenge;

  Reasons({
    this.designedto,
    this.liked,
    this.submitted,
    this.challenge,
  });

  factory Reasons.fromMap(var map) {
    return Reasons(
      designedto: map['designedto'],
      liked: map['liked'],
      submitted: map['submitted'],
      challenge: map['challenge'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['designedto'] = designedto ?? '';
    map['liked'] = liked ?? '';
    map['submitted'] = submitted ?? '';
    map['challenge'] = challenge ?? '';
    return map;
  }
}
