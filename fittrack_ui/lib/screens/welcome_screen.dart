import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:fittrack_ui/model/user_store.dart';

class WelComeScreen extends StatefulWidget {
  @override
  _WelComeScreenState createState() => _WelComeScreenState();
}

class _WelComeScreenState extends State<WelComeScreen> {
  _WelComeScreenState();

  final now = DateTime.now().toUtc().millisecondsSinceEpoch;
  @override
  initState() {
    super.initState();
    move();
  }

  move() async {
    //初期処理としてやることは1つ
    //ログインしているか？（Local Strageのuid,access-token,clientを使ってエラーが返ってこないか？）
    //ログインしている場合→生体データ同期へ（Homeへ）遷移する
    UserStore().prefs = await SharedPreferences.getInstance();
    // String expiry = prefs.getString('expiry') ?? '';
    if ((UserStore().expiry ?? '').isEmpty) {
      await _delay();
      Navigator.pushReplacementNamed(context, '/sign_in');
    } else {
      final expiryDateMicrounixtime = int.parse(UserStore().expiry) * 1000;
      if (expiryDateMicrounixtime <= now) {
        await _delay();
        Navigator.pushReplacementNamed(context, '/sign_in');
      } else {
        await _delay();
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double windowWidth = MediaQuery.of(context).size.width;
    final double windowHeight = MediaQuery.of(context).size.height;
    // ロゴ 縦横比が約 1:1.75
    final double logoWidth = windowWidth * 0.67;
    final double logoHeight = logoWidth / 1.75;

    return Scaffold(
      body: Container(
        color: Colors.white,
        width: windowWidth,
        height: windowHeight,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: (windowWidth - logoWidth) / 2,
              top: windowHeight / 2 - (logoHeight / 1.35), // 1.35は微調整のため
              width: logoWidth,
              child: Image.asset('assets/images/logo.png'),
            ),
          ],
        ),
      ),
    );
  }

  // 最低でもDuration秒はログイン画面までにロゴを表示する
  Future<void> _delay() {
    return Future.delayed(const Duration(milliseconds: 1000));
  }
}
