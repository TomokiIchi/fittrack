import 'dart:ui';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class WelComeScreen extends StatefulWidget {
  @override
  _WelComeScreenState createState() => _WelComeScreenState();
}

class _WelComeScreenState extends State<WelComeScreen> {
  //ログインチェックを_isNeedSignin、ヘルスデータの同期チェックを_isNeedHealthとする（0が必要なし、1が必要あり）
  _WelComeScreenState();

  bool _isNeedUpdate = false;
  bool _isNeedSignin = false;
  bool _isNeedHealth = false;

  @override
  initState() {
    super.initState();
    move();
  }

  //Todo 1. SharedPrefferenceの初期化、データ保持
  //Todo 2. _isNeedUpdateの処理
  //Todo 3. _isNeedSigninの処理
  //Todo 4. _isNeedHealthの処理
  move() async {
    // sharedPreferenceのインスタンスを保存しておく
    // UserStore().prefs = await SharedPreferences.getInstance();
    //アプリを開いたことをAnalyticsにログする
    // AppAnalytics.logAppOpen();
    // Future.wait([
    //   _delay(),
    //   //APIのバージョンをチェック
    //   ApiVersionChecker.isNeedUpadate().then((isNeed) {
    //     _isNeedUpdate = isNeed;
    //   }),
    // ]).whenComplete(() {
    //   if ((UserStore().session ?? '').isNotEmpty) {
    //     // session取得済みの場合
    //     // ユーザ情報を取得してstoreに設定
    //     User.getCurrentUser(withSetStore: true).then((User user) async {
    //       if (user == null) {
    //         // ユーザ情報が取れない場合
    //         // sessionが切れている / ユーザ削除 など？
    //         UserStore.clearSession();
    //         Navigator.pushReplacementNamed(context, '/home');
    //       } else {
    //         Navigator.pushReplacementNamed(context, '/home');
    //       }
    //     });
    //   } else if (_isNeedUpdate) {
    //     showDialog(
    //         barrierDismissible: false,
    //         context: context,
    //         builder: (context) => Material(
    //             type: MaterialType.transparency, child: ApiUpdateDialog()));
    //   } else {
    //     // ログインしていない場合でもHOMEに遷移
    //     Navigator.pushReplacementNamed(context, '/home');
    //   }
    // });
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
              child: InkWell(
                child: Image.asset('assets/images/logo.png'),
                onTap: () =>
                    Navigator.pushReplacementNamed(context, '/sign_in'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 最低でもDuration秒は表示する
  Future<void> _delay() {
    return Future.delayed(const Duration(milliseconds: 1000));
  }
}
