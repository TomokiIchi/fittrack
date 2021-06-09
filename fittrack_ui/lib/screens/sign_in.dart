import 'package:fittrack_ui/utisl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  final SignInType signInType;
// ログイン画面でメッセージを表示するか？
  final bool needSignInMessage;

  // 直接ユーザー登録に遷移したいとき
  SignIn.registration({bool needSignInMessage = false})
      : this(
          signInType: SignInType.registration,
          needSignInMessage: needSignInMessage,
        );

  // ログイン画面（デフォルト）
  SignIn({
    this.signInType = SignInType.login,
    this.needSignInMessage = false,
  }) : super();

  @override
  State<StatefulWidget> createState() {
    return _SignInState();
  }
}

enum SignInType { login, registration }

class _SignInState extends State<SignIn> {
  final TextEditingController _mailEditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  final TextEditingController _nicknameEditingController =
      TextEditingController();
  // static DotEnv _env = DotEnv();
  SignInType _type;

  @override
  void initState() {
    super.initState();
    this._type = widget.signInType;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: ChangeNotifierProvider<SigninMessage>(
          create: (_) => SigninMessage(),
          child: Container(
            child: Column(
              children: <Widget>[
                headerWidget(),
                SizedBox(
                  height: 20,
                ),
                Text(this._type == SignInType.login ? 'ログイン' : 'ユーザー登録',
                    style: TextStyle(
                        color: AppColor.textcolor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
                Divider(color: AppColor.darkColor, indent: 16, endIndent: 16),
                const SizedBox(height: 16),
                // ログイン / ユーザー登録 で差異のある部分
                this._type == SignInType.login
                    ? _loginWidget()
                    : _userRegistrationWidget(),
                SizedBox(height: 50),
                // ユーザー登録のみ表示
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ヘッダー
  Widget headerWidget() {
    return Column(
      children: <Widget>[
        const SizedBox(height: 85),
        Center(
            child: Image.asset('assets/images/logo_splash.png',
                filterQuality: FilterQuality.medium)),
      ],
    );
  }

  // ログイン画面
  Column _loginWidget() {
    return Column(
      children: <Widget>[
        SizedBox(
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 40),
                child: AppText.signinLabel('メールアドレス'),
              ),
              Container(
                padding: EdgeInsets.only(top: 8),
                child: AppInput.input(_mailEditingController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'メールアドレス'),
              ),
              Container(
                  padding: EdgeInsets.only(top: 18),
                  child: Row(
                    children: <Widget>[
                      AppText.signinLabel('パスワード'),
                      SizedBox(width: 10),
                      Text('半角英数記号8文字以上', style: TextStyle(fontSize: 10)),
                    ],
                  )),
              Container(
                padding: EdgeInsets.only(top: 8),
                child: AppInput.input(_passEditingController,
                    keyboardType: TextInputType.visiblePassword,
                    hintText: 'パスワード',
                    obscureText: true),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        Consumer<SigninMessage>(
          builder: (_, SigninMessage message, __) {
            return Container(
              margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Text(
                message.message,
                style: TextStyle(fontSize: 14, color: AppColor.errorcolor),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 300,
          child: SignInButton(
            _mailEditingController,
            _passEditingController,
          ),
        ),
        SizedBox(height: 15),
        Text("ユーザー登録がお済みでない方は", style: TextStyle(fontSize: 16)),
        SizedBox(height: 10),
        GestureDetector(
          child: Text(
            "ユーザー登録",
            style: TextStyle(color: Colors.blueAccent, fontSize: 16),
          ),
          onTap: () {
            setState(() {
              this._type = SignInType.registration;
            });
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }

  // ユーザー登録選択画面
  Column _userRegistrationWidget() {
    return Column(
      children: <Widget>[
        SizedBox(
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // メールアドレス
              Container(
                padding: EdgeInsets.only(top: 40),
                child: AppText.signinLabel('メールアドレス'),
              ),
              Container(
                padding: EdgeInsets.only(top: 8),
                child: AppInput.input(_mailEditingController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'メールアドレス'),
              ),
              Container(
                  padding: EdgeInsets.only(top: 18),
                  child: Row(
                    children: <Widget>[
                      AppText.signinLabel('パスワード'),
                      SizedBox(width: 10),
                      Text('半角英数記号8文字以上', style: TextStyle(fontSize: 10)),
                    ],
                  )),
              Container(
                padding: EdgeInsets.only(top: 8),
                child: AppInput.input(_passEditingController,
                    keyboardType: TextInputType.visiblePassword,
                    hintText: 'パスワード',
                    obscureText: true),
              ),
              Container(
                padding: EdgeInsets.only(top: 26),
                child: AppText.signinLabel('ニックネーム'),
              ),
              Container(
                padding: EdgeInsets.only(top: 8),
                child: AppInput.input(_nicknameEditingController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'ニックネーム'),
              ),
              //エラーメッセージ
              Consumer<SigninMessage>(builder: (_, SigninMessage message, __) {
                return Container(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    message.message,
                    style: TextStyle(fontSize: 14, color: AppColor.errorcolor),
                  ),
                );
              }),
              Container(
                  padding: EdgeInsets.only(top: 15),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: '登録により、',
                        style: TextStyle(color: AppColor.textcolor)),
                    TextSpan(
                      text: '利用規約',
                      style: TextStyle(color: AppColor.lightColor),
                      //TODO 利用規約へのリンク作成
                      // recognizer: TapGestureRecognizer()
                      // ..onTap = () => launch(_env.env['TERMS_URL']),
                    ),
                    TextSpan(
                        text: 'および',
                        style: TextStyle(color: AppColor.textcolor)),
                    TextSpan(
                      text: 'プライバシーポリシー',
                      style: TextStyle(color: AppColor.lightColor),
                      // TODO プライバシーポリシーへのリンク作成
                      // recognizer: TapGestureRecognizer()
                      // ..onTap = () =>
                      // launch(_env.env['PRIVACY_POLICY_URL']),
                    ),
                    TextSpan(
                        text: 'に同意したとみなされます。',
                        style: TextStyle(color: AppColor.textcolor)),
                  ]))),
              SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: SignupButton(
                  _mailEditingController,
                  _passEditingController,
                  _nicknameEditingController,
                ),
              ),
              SizedBox(height: 15),
              Center(
                  child: Text("ユーザー登録がお済みの方は", style: TextStyle(fontSize: 16))),
              SizedBox(height: 5),
              Center(
                child: GestureDetector(
                  child: Text(
                    "ログイン",
                    style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                  ),
                  onTap: () {
                    setState(() {
                      this._type = SignInType.login;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class SigninMessage extends ChangeNotifier {
  String message = "";
  String snsMessage = "";

  void clear() {
    message = "";
    snsMessage = "";
  }

  void setMessage(_message) {
    clear();
    message = _message;
    notifyListeners();
  }
}

enum ButtonType {
  normal,
  registeration,
}

class AppButton extends Container {
  final ButtonType buttonType;
  final VoidCallback onPressed;
  final text;

  static Widget withSize(text,
      {double height = 44.0,
      double minWidth = 300,
      Function onPressed,
      ButtonType buttonType}) {
    return ButtonTheme(
      height: height,
      minWidth: minWidth,
      child: AppButton(text, () => onPressed(), buttonType: buttonType),
    );
  }

  AppButton(this.text, this.onPressed, {this.buttonType = ButtonType.normal})
      : super();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Visibility(
              visible: _iconPath.isNotEmpty,
              child: Image.asset(_iconPath, width: 30, height: 30)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [AppText.appButton(text)],
          ),
        ],
      ),
      onPressed: onPressed,
    );
  }

  String get _iconPath {
    switch (buttonType) {
      default:
        return '';
    }
  }
}

class AppText extends Text {
  AppText(value,
      {double fontSize = 14,
      FontWeight fontWeight = FontWeight.w300,
      Color color,
      int maxLines,
      TextOverflow overflow})
      : super(
          value,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
          ),
          maxLines: maxLines,
          overflow: overflow,
        );

  AppText.appButton(value, {Color color})
      : super(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        );

  // サインイン画面のラベル
  AppText.signinLabel(value)
      : super(
          value,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColor.textcolor),
        );
}

class AppInput {
  static double defaultHeight = 32;

  static Widget input(TextEditingController controller,
      {hintText = "",
      keyboardType = TextInputType.text,
      obscureText = false,
      autofocus = false}) {
    return SizedBox(
      height: defaultHeight,
      child: Container(
        margin: EdgeInsets.only(top: 1),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.yellow),
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
        ),
        child: Container(
          child: Align(
            alignment: Alignment.centerLeft,
            child: TextField(
              cursorColor: AppColor.midColor,
              autofocus: autofocus,
              obscureText: obscureText,
              cursorWidth: 1.0,
              keyboardType: keyboardType,
              controller: controller,
              decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: TextStyle(fontSize: 12)),
              style: TextStyle(fontSize: 16),
              maxLines: 1,
            ),
          ),
        ),
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  final TextEditingController mailEditingController;
  final TextEditingController passEditingController;

  SignInButton(
    this.mailEditingController,
    this.passEditingController,
  );

  @override
  Widget build(BuildContext context) {
    final SigninMessage message =
        Provider.of<SigninMessage>(context, listen: false);
    return AppButton.withSize("ログイン", onPressed: () async {
      try {
        var url =
            Uri.parse('http://fittrack.sakigake.tech/api/v1/auth/sign_in');
        var response = await http.post(url, body: {
          'email': mailEditingController.text,
          'password': passEditingController.text,
        });
        if (response.statusCode != 201 && response.statusCode != 200) {
          message.setMessage(
              // TODO statusCodeではなく エラーの内容を出した方が良いと思う
              'Request failed with status: ${response.statusCode}.');
        } else if (response == null) {
          // ここは通らないかもしれなが念の為
          message.setMessage("入力内容を確認してください");
        } else {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('uid', response.headers["uid"]);
          prefs.setString('accesstoken', response.headers["access-token"]);
          prefs.setString('client', response.headers["client"]);
          // TODO shared preferenceのキーは定数にしておいた方がいいと思います
          prefs.setString('expiry', response.headers["expiry"]);

          Navigator.pushReplacementNamed(context, '/home');
        }
      } catch (e) {
        message.setMessage("エラーが発生しました");
      }
    });
  }
}

class SignupButton extends StatelessWidget {
  final TextEditingController mailEditingController;
  final TextEditingController passEditingController;
  final TextEditingController nicknameEditingController;

  SignupButton(
    this.mailEditingController,
    this.passEditingController,
    this.nicknameEditingController,
  );

  @override
  Widget build(BuildContext context) {
    final SigninMessage message =
        Provider.of<SigninMessage>(context, listen: false);
    return AppButton.withSize("登録する", onPressed: () async {
      try {
        var url = Uri.parse('http://fittrack.sakigake.tech/api/v1/auth/');
        var response = await http.post(url, body: {
          'email': mailEditingController.text,
          'password': passEditingController.text,
          "password_confirmation": passEditingController.text
        });
        if (response.statusCode != 201 && response.statusCode != 200) {
          message.setMessage(
              // TODO statusCodeではなく エラーの内容を出した方が良いと思う
              'Request failed with status: ${response.statusCode}.');
        } else if (response == null) {
          // ここは通らないかもしれなが念の為
          message.setMessage("入力内容を確認してください");
        } else {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('uid', response.headers["uid"]);
          prefs.setString('accesstoken', response.headers["access-token"]);
          prefs.setString('client', response.headers["client"]);
          // TODO shared preferenceのキーは定数にしておいた方がいいと思います
          prefs.setString('expiry', response.headers["expiry"]);

          Navigator.pushReplacementNamed(context, '/home');
        }
      } catch (e) {
        message.setMessage("エラーが発生しました。$e");
      }
    });
  }
}
