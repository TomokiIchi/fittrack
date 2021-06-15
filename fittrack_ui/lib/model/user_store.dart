import 'package:shared_preferences/shared_preferences.dart';

class UserStore {
  static UserStore _store = UserStore._internal();
  factory UserStore() => _store;
  UserStore._internal();

  SharedPreferences prefs;
  static String prefKeyUid = "uid";
  static String prefKeyAccesstoken = "accesstoken";
  static String prefKeyClient = "client";
  static String prefKeyExpiry = "expiry";

  get uid => prefs.getString(UserStore.prefKeyUid) ?? '';
  set uid(value) => UserStore().prefs.setString(UserStore.prefKeyUid, value);
  get accesstoken => prefs.getString(UserStore.prefKeyAccesstoken) ?? '';
  set accesstoken(value) =>
      UserStore().prefs.setString(UserStore.prefKeyAccesstoken, value);
  get client => prefs.getString(UserStore.prefKeyClient) ?? '';
  set client(value) =>
      UserStore().prefs.setString(UserStore.prefKeyClient, value);
  get expiry => prefs.getString(UserStore.prefKeyExpiry) ?? '';
  set expiry(value) =>
      UserStore().prefs.setString(UserStore.prefKeyExpiry, value);

  static clearSession() {
    UserStore().uid = "";
    UserStore().accesstoken = "";
    UserStore().client = "";
    UserStore().expiry = "";
  }
}
