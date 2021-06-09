import 'package:fittrack_ui/screens/data_screen.dart';
import 'package:fittrack_ui/style.dart';
import 'package:fittrack_ui/widgets/moods.dart';
import 'package:flutter/material.dart';
import 'package:fittrack_ui/utisl.dart';
import 'dart:async';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:fit_kit/fit_kit.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // TODO この結果を表示しているところはありますかね？
  String result = '';
  Map<DataType, List<FitData>> results = Map();
  final Map<String, List> biometricdata = {};
  bool permissions;

  // FitKitの使い方
  // Map<DataType, List<FitData>> MAP_NAME = await read()
  // FitDataはsrc/fit_data.dartで定義されている。num value、DateTime dateFrom、DateTime dateTo、String source、bool userEnteredの5つの変数を持つ。
  // DataTypeはsrc/fit_kit.dartで定義されている。10種類のString。

  @override
  void initState() {
    super.initState();
    // TODO このメソッドは特に必要なさそうに見えます
    fetchPermissions();
    read();
    // TODO read()の結果 biometricdataを反映させるためには setState()なので もう一度buildさせる必要があると思います。
    // TODO initStateとbuildは非同期で呼ばれる為
  }

  Future<void> read() async {
    results.clear();
    try {
      permissions = await FitKit.requestPermissions(DataType.values);
      if (!permissions) {
        // TODO この結果を表示しているところはありますかね？
        result = 'requestPermissions: failed';
        return;
      }
      for (DataType type in DataType.values) {
        try {
          results[type] = await FitKit.read(
            type,
            dateFrom: DateTime.now().subtract(Duration(days: 7)),
            dateTo: DateTime.now(),
          );
        } on UnsupportedException catch (e) {
          results[e.dataType] = [];
        }
      }
      result = 'readAll: success';
      results.forEach((key, value) {
        if (key is DataType) {
          biometricdata['$key'] = value;
        }
      });
    } catch (e) {
      result = 'readAll: $e';
    }
  }

  //TODO 使ってなさそう せっかくなので権限を無効にできる機能が使えても良いかな
  //TODO lib/screens/home_screen.dart の revokePermissions()  が使われている形跡がないのですが、必要なのでしょうか？
  Future<void> revokePermissions() async {
    results.clear();
    try {
      await FitKit.revokePermissions();
      permissions = await FitKit.hasPermissions(DataType.values);
      result = 'revokePermissions: success';
    } catch (e) {
      result = 'revokePermissions: $e';
    }
  }

  Future<void> fetchPermissions() async {
    try {
      permissions = await FitKit.hasPermissions(DataType.values);
    } catch (e) {
      result = 'hasPermissions: $e';
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _buildTopStack(),
                SizedBox(
                  height: 60.0,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildNextAppointmentTitle(),
                      _buildNextAppointmentInfo(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
            margin: EdgeInsets.all(10),
            child: FloatingActionButton(
              child: Icon(
                Icons.update_sharp,
                size: 32,
              ),
              onPressed: () => read(),
              backgroundColor: AppColor.lightColor,
            )));
  }

  Stack _buildTopStack() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.topCenter,
      children: <Widget>[
        _buildBackgroundCover(),
        _buildGreetings(),
        _buildMoodsHolder(),
      ],
    );
  }

  _buildBackgroundCover() {
    return Container(
      height: 260.0,
      decoration: BoxDecoration(
          gradient: AppColor.purpleGradient,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40))),
    );
  }

  _buildGreetings() {
    return Positioned(
      left: 20.0,
      bottom: 90.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hi!',
            style: AppStyle.greetingTitleStyle,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'How are you feeling today?',
            style: AppStyle.greetingSubtitleStyle,
          ),
        ],
      ),
    );
  }

  _buildMoodsHolder() {
    return Positioned(
      //Todo lib/screens/home_screen.dart のL:215でbottom: -45となっていますが、画面サイズが違う場合に期待するUIになるのか気になりました。iPhone 12 Pro Max とiPhone SEなど
      bottom: -45,
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width - 40,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(28)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 5.5,
                blurRadius: 5.5,
              )
            ]),
        child: MyMoods(),
      ),
    );
  }

  _buildNextAppointmentTitle() {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Latest data', style: AppStyle.nextAppointmentTitleStyle),
          InkWell(
              child: Text(
                'See All',
                style: AppStyle.nextAppointmentSubTitleStyle,
              ),
              onTap: () {
                results.forEach((key, value) {
                  print('Key:$key, Value:$value');
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        // TODO データが取れていない状態で遷移すると落ちます
                        builder: (context) =>
                            DataPage(biometricdata: biometricdata)));
              }),
        ],
      ),
    );
  }

  _buildNextAppointmentInfo() {
    final heartrate = biometricdata.isEmpty
        ? 0
        : biometricdata['DataType.HEART_RATE'].last.value.round();
    final heartratetime = biometricdata.isEmpty
        ? 0
        : biometricdata['DataType.HEART_RATE'].last.dateTo;
    final steps = biometricdata.isEmpty
        ? 0
        : biometricdata['DataType.STEP_COUNT'].last.value.round();
    final stepstime = biometricdata.isEmpty
        ? 0
        : biometricdata['DataType.STEP_COUNT'].last.dateTo;
    final energy = biometricdata.isEmpty
        ? 0
        : biometricdata['DataType.ENERGY'].last.value.round();
    final energytime = biometricdata.isEmpty
        ? 0
        : biometricdata['DataType.ENERGY'].last.dateTo;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 18.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(18)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 5.5,
              blurRadius: 5.5,
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                LineAwesomeIcons.heart,
                size: 40,
                color: Colors.redAccent,
              ),
              SizedBox(
                width: 12,
              ),
              RichText(
                  text: TextSpan(
                      text: '心拍数 $heartrate BPM',
                      style: AppStyle.appointmentMainStyle,
                      children: [
                    TextSpan(
                      text: '\n $heartratetime',
                      style: AppStyle.appointmentDatastyle,
                    ),
                  ]))
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 18)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                LineAwesomeIcons.map_marker,
                size: 40,
                color: Colors.blueGrey,
              ),
              SizedBox(
                width: 12,
              ),
              RichText(
                  text: TextSpan(
                      text: '歩数：$steps 歩',
                      style: AppStyle.appointmentMainStyle,
                      children: [
                    TextSpan(
                      text: '\n $stepstime',
                      style: AppStyle.appointmentDatastyle,
                    ),
                  ]))
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 18)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                LineAwesomeIcons.fire,
                size: 40,
                color: Colors.green,
              ),
              SizedBox(
                width: 12,
              ),
              RichText(
                  text: TextSpan(
                      text: '$energy kCal',
                      style: AppStyle.appointmentMainStyle,
                      children: [
                    TextSpan(
                      text: '\n $energytime',
                      style: AppStyle.appointmentDatastyle,
                    ),
                  ]))
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }
}
