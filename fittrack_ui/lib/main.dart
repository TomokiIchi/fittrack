import 'package:fittrack_ui/style.dart';
import 'package:fittrack_ui/widgets/moods.dart';
import 'package:flutter/material.dart';
import 'package:fittrack_ui/utisl.dart';
import 'dart:async';
import 'package:health/health.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitTrack',
      theme: ThemeData(primaryColor: Colors.blue),
      home: MyHomePage(),
    );
  }
}

enum AppState {
  DATA_NOT_FETCHED,
  FETCHING_DATA,
  DATA_READY,
  NO_DATA,
  AUTH_NOT_GRANTED
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  List<HealthDataPoint> _healthDataList = [];
  AppState _state = AppState.DATA_NOT_FETCHED;

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchData() async {
    /// Get everything from midnight until now
    DateTime startDate = DateTime(2021, 03, 01, 0, 0, 0);
    DateTime endDate = DateTime(2021, 03, 01, 23, 59, 59);

    HealthFactory health = HealthFactory();

    /// Define the types to get.
    List<HealthDataType> types = [
      HealthDataType.STEPS,
      HealthDataType.WEIGHT,
      HealthDataType.HEIGHT,
      HealthDataType.SLEEP_ASLEEP,
      HealthDataType.SLEEP_AWAKE,
      HealthDataType.SLEEP_IN_BED,
      HealthDataType.HEART_RATE,
    ];

    setState(() => _state = AppState.FETCHING_DATA);

    /// You MUST request access to the data types before reading them
    bool accessWasGranted = await health.requestAuthorization(types);

    if (accessWasGranted) {
      try {
        /// Fetch new data
        List<HealthDataPoint> healthData =
            await health.getHealthDataFromTypes(startDate, endDate, types);

        /// Save all the new data points
        _healthDataList.addAll(healthData);
      } catch (e) {
        print("Caught exception in getHealthDataFromTypes: $e");
      }

      /// Filter out duplicates
      _healthDataList = HealthFactory.removeDuplicates(_healthDataList);

      /// Print the results
      _healthDataList.forEach((x) {
        print("Data point: $x \n");
      });
      print(_healthDataList);
      // Update the UI to display the results
      setState(() {
        _state =
            _healthDataList.isEmpty ? AppState.NO_DATA : AppState.DATA_READY;
      });
    } else {
      print("Authorization not granted");
      setState(() => _state = AppState.DATA_NOT_FETCHED);
    }
  }

  Widget _contentFetchingData() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(
              strokeWidth: 10,
            )),
        Text('Fetching data...')
      ],
    );
  }

  Widget _contentDataReady() {
    return ListView.builder(
        itemCount: _healthDataList.length,
        itemBuilder: (_, index) {
          HealthDataPoint p = _healthDataList[index];
          return ListTile(
            title: Text("${p.typeString}: ${p.value}"),
            trailing: Text('${p.unitString}'),
            subtitle: Text('${p.dateFrom} - ${p.dateTo}'),
          );
        });
  }

  Widget _contentNoData() {
    return Text('No Data to show');
  }

  Widget _contentNotFetched() {
    return Text('Press the download button to fetch data');
  }

  Widget _authorizationNotGranted() {
    return Text('''Authorization not given.
        For Android please check your OAUTH2 client ID is correct in Google Developer Console.
         For iOS check your permissions in Apple Health.''');
  }

  Widget _content() {
    if (_state == AppState.DATA_READY)
      return _contentDataReady();
    else if (_state == AppState.NO_DATA)
      return _contentNoData();
    else if (_state == AppState.FETCHING_DATA)
      return _contentFetchingData();
    else if (_state == AppState.AUTH_NOT_GRANTED)
      return _authorizationNotGranted();

    return _contentNotFetched();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBgColor,
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
                    // _buildNotificationCard(),
                    _buildNextAppointmentTitle(),
                    _buildNextAppointmentInfo(),
                    //Todo 取得したアカウント情報を以下の２つで表示
                    // _buildProfileTitle(),
                    // _buildProfileInfo(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                LineAwesomeIcons.home,
                size: 30.0,
              ),
              title: Text('1')),
          BottomNavigationBarItem(
              icon: Icon(
                LineAwesomeIcons.search,
                size: 30.0,
              ),
              title: Text('1')),
          BottomNavigationBarItem(
              icon: Icon(
                LineAwesomeIcons.gratipay,
                size: 30.0,
              ),
              title: Text('1')),
        ],
        onTap: onTapped,
      ),
    );
  }

  Stack _buildTopStack() {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      overflow: Overflow.visible,
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
          gradient: purpleGradient,
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
            'Hi Tomoki',
            style: greetingTitleStyle,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'How are you feeling today?',
            style: greetingSubtitleStyle,
          ),
        ],
      ),
    );
  }

  _buildMoodsHolder() {
    return Positioned(
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

  _buildNotificationCard() {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: lightColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(
          LineAwesomeIcons.heart,
          color: Colors.white,
          size: 32,
        ),
        title: Text(
          'Heart Rate $_selectedIndex',
          style: notificationTitleStyle,
        ),
        trailing: OutlineButton(
          onPressed: () {},
          color: Colors.transparent,
          borderSide: BorderSide(color: Colors.white, width: 1.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
          child: Text(
            'Detail',
            style: notificationButtonStyle,
          ),
        ),
      ),
    );
  }

  _buildNextAppointmentTitle() {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Today\'s data', style: nextAppointmentTitleStyle),
          InkWell(
            child: Text(
              'See All',
              style: nextAppointmentSubTitleStyle,
            ),
            onTap: () => fetchData(),
          ),
        ],
      ),
    );
  }

  _buildNextAppointmentInfo() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 18.0),
      // decoration: BoxDecoration(
      //     color: Colors.white, borderRadius: BorderRadius.circular(18)),
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
              // CircleAvatar(
              //   backgroundColor: Colors.grey,
              //   backgroundImage: NetworkImage(USER_IMAGE),
              //   radius: 36,
              // ),
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
                      text: '心拍数：78 BPM',
                      style: appointmentMainStyle,
                      children: [
                    TextSpan(
                      text: '\n Now',
                      style: appointmentDatastyle,
                    ),
                  ]))
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 18)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CircleAvatar(
              //   backgroundColor: Colors.grey,
              //   backgroundImage: NetworkImage(USER_IMAGE),
              //   radius: 36,
              // ),
              Icon(
                LineAwesomeIcons.bed,
                size: 40,
                color: Colors.green,
              ),
              SizedBox(
                width: 12,
              ),
              RichText(
                  text: TextSpan(
                      text: '昨日は7時間37分眠りました',
                      style: appointmentMainStyle,
                      children: [
                    TextSpan(
                      text: '\n Now',
                      style: appointmentDatastyle,
                    ),
                  ]))
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 18)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CircleAvatar(
              //   backgroundColor: Colors.grey,
              //   backgroundImage: NetworkImage(USER_IMAGE),
              //   radius: 36,
              // ),
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
                      text: '歩数：6789',
                      style: appointmentMainStyle,
                      children: [
                    TextSpan(
                      text: '\n Now',
                      style: appointmentDatastyle,
                    ),
                  ]))
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          // Divider(
          //   color: Colors.grey[200],
          //   height: 3.0,
          //   thickness: 1,
          // ),
          // SizedBox(
          //   height: 8.0,
          // ),
        ],
      ),
    );
  }

  void onTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}
