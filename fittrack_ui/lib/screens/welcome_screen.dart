import 'dart:ui';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fittrack_ui/screens/home_screen.dart';
import 'package:fittrack_ui/utisl.dart';
import 'package:flutter/material.dart';

class WelComeScreen extends StatefulWidget {
  @override
  _WelComeScreenState createState() => _WelComeScreenState();
}

class _WelComeScreenState extends State<WelComeScreen> {
  _WelComeScreenState();

  bool _isNeedUpdate;

  @override
  initState() {
    super.initState();
    move();
  }

  move() async {
    // sharedPreferenceのインスタンスを保存しておく
    // UserStore().prefs = await SharedPreferences.getInstance();
    // //アプリを開いたことをAnalyticsにログする
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
    // Navigator.pushNamed(context, '/home');
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

// class WelcomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Body(),
//     );
//   }
// }

// class Body extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     // This size provide us total height and width of our screen
//     return Background(
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               "WELCOME To Fittrack",
//               style:
//                   TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//             ),
//             SizedBox(height: size.height * 0.05),
//             SizedBox(height: size.height * 0.05),
//             ClipRect(
//               child: TextButton(
//                 onPressed: () {},
//                 child: Text(
//                   'Longin',
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//             RoundedButton(
//               text: "LOGIN",
//               press: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) {
//                       return MyHomePage();
//                     },
//                   ),
//                 );
//               },
//             ),
//             RoundedButton(
//               text: "SIGN UP",
//               color: lightColor,
//               textColor: Colors.black,
//               press: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) {
//                       return MyHomePage();
//                     },
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class RoundedButton extends StatelessWidget {
//   final String text;
//   final Function press;
//   final Color color, textColor;
//   const RoundedButton({
//     Key key,
//     this.text,
//     this.press,
//     this.color = lightColor,
//     this.textColor = Colors.black,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 10),
//       width: size.width * 0.8,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(29),
//         child: FlatButton(
//           padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
//           color: color,
//           onPressed: press,
//           child: Text(
//             text,
//             style: TextStyle(color: textColor),
//           ),
//         ),
//       ),
//     );
//   }
// }
