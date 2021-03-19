import 'package:fittrack_ui/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:fittrack_ui/utisl.dart';
import 'screens/welcome_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitTrack',
      theme: ThemeData(
        primaryColor: lightColor,
        primarySwatch: Colors.deepPurple,
        accentColor: lightColor,
        // fontFamily: 'SourceSansPro',
        textTheme: TextTheme(
          display2: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 45.0,
            // fontWeight: FontWeight.w400,
            color: Colors.orange,
          ),
          button: TextStyle(
            // OpenSans is similar to NotoSans but the uppercases look a bit better IMO
            fontFamily: 'OpenSans',
          ),
          caption: TextStyle(
            fontFamily: 'NotoSans',
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            color: Colors.deepPurple[300],
          ),
          overline: TextStyle(fontFamily: 'NotoSans'),
        ),
      ),
      routes: <String, WidgetBuilder>{
        // '/': (BuildContext context) => Provider<SplashBloc>(
        //       builder: (context) => SplashBloc(),
        //       child: SplashPage(),
        //       dispose: (_, bloc) {
        //         bloc.dispose();
        //       },
        //     ),
        '/': (BuildContext context) => WelcomeScreen(),
        // '/login': (BuildContext context) => FlutterLogin(),
      },
    );
  }
}
