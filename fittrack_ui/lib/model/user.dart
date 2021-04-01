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
  bool _isNeedHealthDataSync;

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

  // --------------------------------
  // ユーザ情報を取得 / storeにもセット
  // static Future<User> getCurrentUser({bool withSetStore = true}) {
  //   User _user;
  //   Completer<User> completer = new Completer<User>();
  //   AppClient()
  //       .client()
  //       .query(QueryOptions(documentNode: gql(AppQuery.getCurrentUser())))
  //       .then((result) {
  //     if (result.data != null && result.data["currentUser"] != null) {
  //       _user = User.from(result.data['currentUser']);
  //     }
  //     completer.complete(_user);
  //     if (withSetStore) {
  //       UserStore().currentUser = _user;
  //     }

  //     // ユーザー情報をAnalyticsにログする
  //     AppAnalytics.setUserProperty(_user);
  //   });
  //   return completer.future;
  // }

  // static Future<User> getUserById(id) {
  //   User _user;
  //   Completer<User> completer = new Completer<User>();

  //   AppClient()
  //       .client()
  //       .query(QueryOptions(
  //           documentNode: gql(AppQuery.getUser()),
  //           variables: <String, dynamic>{'id': id}))
  //       .then((result) {
  //     if (result.data["user"] != null) {
  //       _user = User.from(result.data['user']);
  //     }
  //     completer.complete(_user);
  //   });
  //   return completer.future;
  // }

  // static Future<User> getUserSelf() {
  //   User _user;
  //   Completer<User> completer = new Completer<User>();

  //   AppClient()
  //       .client()
  //       .query(QueryOptions(
  //         documentNode: gql(AppQuery.getUserSelf()),
  //       ))
  //       .then((result) {
  //     if (result.data["userSelf"] != null) {
  //       _user = User.from(result.data['userSelf']);
  //     }
  //     completer.complete(_user);
  //   });
  //   return completer.future;
  // }

  // static Future<QueryResult> updateProfileMutation({
  //   @required int iconFileId,
  //   @required String name,
  //   @required String nickname,
  //   @required String area,
  //   @required String profile,
  //   @required String catchCopy,
  //   @required String kana,
  // }) {
  //   final MutationOptions options = MutationOptions(
  //     documentNode: gql(AppMutation.updateProfileMutation()),
  //     variables: <String, dynamic>{
  //       'iconFileId': iconFileId,
  //       'name': name,
  //       'nickname': nickname,
  //       'area': area,
  //       'profile': profile,
  //       'catchCopy': catchCopy,
  //       'kana': kana,
  //     },
  //   );
  //   return AppClient().client().mutate(options);
  // }
}
