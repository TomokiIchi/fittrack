// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:graphql/client.dart';
// import 'package:tabica_app/components/general/app_analytics.dart';
// import 'package:tabica_app/graphql/app_client.dart';
// import 'package:tabica_app/graphql/app_mutation.dart';
// import 'package:tabica_app/graphql/app_query.dart';
// import 'package:tabica_app/store/user_store.dart';
// import 'package:tabica_app/utils/date_util.dart';

// class User {
//   final int id;
//   final String name;
//   final String nickname;
//   final String userType;
//   final String mail;
//   final DateTime signedInAt;
//   final Map<String, dynamic> srcset;
//   final String profile;
//   final String tel;
//   final Map<String, dynamic> customer;
//   final bool telVerified;
//   final bool mailVerified;
//   final String area;
//   final int iconId;
//   final Map<String, dynamic> supplier;

//   get kana => customer["ex"]["kana"];
//   // ホストの場合 true
//   get isSupplier => ["supplier_and_customer", "supplier"].contains(userType);
//   get catchCopy => supplier["ex"]["catchCopy"];

//   User.from(Map<String, dynamic> data)
//       : this(
//           id: data["id"],
//           name: data["name"],
//           nickname: data["nickname"],
//           userType: data["userType"] ?? '',
//           mail: data["mail"],
//           signedInAt: DateUtil.toDateTime(data["signedInAt"]),
//           srcset: data["srcset"],
//           profile: data["profile"],
//           tel: data["tel"],
//           customer: data["customer"],
//           telVerified: data["telVerified"],
//           mailVerified: data["mailVerified"],
//           area: data["area"],
//           iconId: data["iconId"],
//           supplier: data["supplier"] ?? {"ex": {}},
//         );

//   User({
//     this.id,
//     this.name,
//     this.nickname,
//     this.userType,
//     this.mail,
//     this.signedInAt,
//     this.srcset,
//     this.profile,
//     this.tel,
//     this.customer,
//     this.telVerified,
//     this.mailVerified,
//     this.area,
//     this.iconId,
//     this.supplier,
//   });

//   // --------------------------------
//   // ユーザ情報を取得 / storeにもセット
//   static Future<User> getCurrentUser({bool withSetStore = true}) {
//     User _user;
//     Completer<User> completer = new Completer<User>();
//     AppClient()
//         .client()
//         .query(QueryOptions(documentNode: gql(AppQuery.getCurrentUser())))
//         .then((result) {
//       if (result.data != null && result.data["currentUser"] != null) {
//         _user = User.from(result.data['currentUser']);
//       }
//       completer.complete(_user);
//       if (withSetStore) {
//         UserStore().currentUser = _user;
//       }

//       // ユーザー情報をAnalyticsにログする
//       AppAnalytics.setUserProperty(_user);
//     });
//     return completer.future;
//   }

//   static Future<User> getUserById(id) {
//     User _user;
//     Completer<User> completer = new Completer<User>();

//     AppClient()
//         .client()
//         .query(QueryOptions(
//             documentNode: gql(AppQuery.getUser()),
//             variables: <String, dynamic>{'id': id}))
//         .then((result) {
//       if (result.data["user"] != null) {
//         _user = User.from(result.data['user']);
//       }
//       completer.complete(_user);
//     });
//     return completer.future;
//   }

//   static Future<User> getUserSelf() {
//     User _user;
//     Completer<User> completer = new Completer<User>();

//     AppClient()
//         .client()
//         .query(QueryOptions(
//           documentNode: gql(AppQuery.getUserSelf()),
//         ))
//         .then((result) {
//       if (result.data["userSelf"] != null) {
//         _user = User.from(result.data['userSelf']);
//       }
//       completer.complete(_user);
//     });
//     return completer.future;
//   }

//   static Future<QueryResult> updateProfileMutation({
//     @required int iconFileId,
//     @required String name,
//     @required String nickname,
//     @required String area,
//     @required String profile,
//     @required String catchCopy,
//     @required String kana,
//   }) {
//     final MutationOptions options = MutationOptions(
//       documentNode: gql(AppMutation.updateProfileMutation()),
//       variables: <String, dynamic>{
//         'iconFileId': iconFileId,
//         'name': name,
//         'nickname': nickname,
//         'area': area,
//         'profile': profile,
//         'catchCopy': catchCopy,
//         'kana': kana,
//       },
//     );
//     return AppClient().client().mutate(options);
//   }
// }
