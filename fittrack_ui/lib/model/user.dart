import 'date_util.dart';

class User {
  final int id;
  final String name;
  final String nickname;
  final String mail;
  final DateTime signedInAt;
  final Map<String, dynamic> srcset;
  final String profile;
  String uid;
  String accesstoken;
  String client;
  int expiry;

  User.from(Map<String, dynamic> data)
      : this(
          id: data["id"],
          name: data["name"],
          nickname: data["nickname"],
          mail: data["mail"],
          signedInAt: DateUtil.toDateTime(data["signedInAt"]),
          srcset: data["srcset"],
          profile: data["profile"],
        );

  User({
    this.id,
    this.name,
    this.nickname,
    this.mail,
    this.signedInAt,
    this.srcset,
    this.profile,
    this.uid,
    this.accesstoken,
    this.client,
  });
}
