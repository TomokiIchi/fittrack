import 'package:fittrack_ui/utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DataPage extends StatelessWidget {
  final Map<String, List> biometricdata;
  DataPage({this.biometricdata});

  Stack _buildTopStack() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.topCenter,
      children: <Widget>[
        AppBar(
          title: Text(
            'Detail Data',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.5,
            ),
          ),
          backgroundColor: AppColor.lightColor,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const cutOffYValue = 5.0;
    final double windowWidth = MediaQuery.of(context).size.width;
    final double windowHeight = MediaQuery.of(context).size.height;
    DateTime now = DateTime.now();
    final heartspot = biometricdata['DataType.HEART_RATE']?.isEmpty ?? true
        ? [FlSpot(0, 40)]
        : biometricdata['DataType.HEART_RATE']
            .where((element) =>
                element.dateTo.day == now.add(Duration(days: 0)).day)
            .toList()
            .map((e) => FlSpot(
                e.dateTo.hour.toDouble() + (e.dateTo.minute / 60).toDouble(),
                e.value.toDouble()))
            .toList();
    final steps = biometricdata['DataType.STEP_COUNT']?.isEmpty ?? true
        ? [
            FlSpot(1, 2000),
            FlSpot(2, 2000),
            FlSpot(3, 2000),
            FlSpot(4, 2000),
            FlSpot(5, 2000),
            FlSpot(6, 2000),
            FlSpot(7, 2000)
          ]
        : biometricdata['DataType.STEP_COUNT']
            .map((e) => FlSpot(e.dateTo.weekday.toDouble(), e.value.toDouble()))
            .toList();
    List<FlSpot> stepspot = [];
    stepspot.add(steps
        .where((element) => element.x == 1)
        .reduce((value, element) => FlSpot(value.x, value.y + element.y)));
    stepspot.add(steps
        .where((element) => element.x == 2)
        .reduce((value, element) => FlSpot(value.x, value.y + element.y)));
    stepspot.add(steps
        .where((element) => element.x == 3)
        .reduce((value, element) => FlSpot(value.x, value.y + element.y)));
    stepspot.add(steps
        .where((element) => element.x == 4)
        .reduce((value, element) => FlSpot(value.x, value.y + element.y)));
    stepspot.add(steps
        .where((element) => element.x == 5)
        .reduce((value, element) => FlSpot(value.x, value.y + element.y)));
    stepspot.add(steps
        .where((element) => element.x == 6)
        .reduce((value, element) => FlSpot(value.x, value.y + element.y)));
    stepspot.add(steps
        .where((element) => element.x == 7)
        .reduce((value, element) => FlSpot(value.x, value.y + element.y)));

    print(stepspot);
    print(heartspot);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildTopStack(),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20, right: 20),
                child: Container(
                  width: windowWidth,
                  height: windowHeight / 3,
                  child: LineChart(
                    LineChartData(
                      lineTouchData: LineTouchData(enabled: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: heartspot,
                          isCurved: true,
                          barWidth: 2,
                          colors: [
                            Colors.redAccent,
                          ],
                          belowBarData: BarAreaData(
                            show: false,
                            colors: [Colors.deepPurple.withOpacity(0.4)],
                            cutOffY: cutOffYValue,
                            applyCutOffY: true,
                          ),
                          aboveBarData: BarAreaData(
                            show: false,
                            colors: [Colors.orange.withOpacity(0.6)],
                            cutOffY: cutOffYValue,
                            applyCutOffY: true,
                          ),
                          dotData: FlDotData(
                            show: false,
                          ),
                        ),
                      ],
                      minY: 0,
                      minX: 0,
                      maxX: 24,
                      titlesData: FlTitlesData(
                        bottomTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 12,
                          getTextStyles: (value) =>
                              TextStyle(color: Colors.black, fontSize: 10),
                        ),
                        leftTitles: SideTitles(
                          interval: 40,
                          showTitles: true,
                          getTitles: (value) {
                            return '$value';
                          },
                        ),
                      ),
                      axisTitleData: FlAxisTitleData(
                          leftTitle: AxisTitle(
                              showTitle: true, titleText: 'BPM', margin: 2),
                          bottomTitle: AxisTitle(
                              showTitle: true,
                              margin: 8,
                              titleText: 'Heart Rate',
                              textStyle:
                                  TextStyle(fontSize: 22, color: Colors.black),
                              textAlign: TextAlign.center)),
                      gridData: FlGridData(
                        show: true,
                        checkToShowHorizontalLine: (double value) {
                          return value == 40 ||
                              value == 85 ||
                              value == 130 ||
                              value == 175 ||
                              value == 220;
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 20, bottom: 20, right: 20, left: 20),
                child: Container(
                  width: windowWidth,
                  height: windowHeight / 3,
                  child: LineChart(
                    LineChartData(
                      lineTouchData: LineTouchData(enabled: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: stepspot,
                          isCurved: true,
                          barWidth: 4,
                          colors: [
                            Colors.blueGrey,
                          ],
                          belowBarData: BarAreaData(
                            show: true,
                            colors: [Colors.blueGrey.withOpacity(0.4)],
                            cutOffY: cutOffYValue,
                            applyCutOffY: false,
                          ),
                          aboveBarData: BarAreaData(
                            show: false,
                            colors: [Colors.orange.withOpacity(0.6)],
                            cutOffY: cutOffYValue,
                            applyCutOffY: true,
                          ),
                          dotData: FlDotData(
                            show: false,
                          ),
                        ),
                      ],
                      minY: 2000,
                      maxY: 12000,
                      titlesData: FlTitlesData(
                        bottomTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 12,
                          getTitles: (double value) {
                            switch (value.toInt()) {
                              case 1:
                                return 'Mon';
                              case 2:
                                return 'Tue';
                              case 3:
                                return 'Wed';
                              case 4:
                                return 'Thu';
                              case 5:
                                return 'Fri';
                              case 6:
                                return 'Sat';
                              case 7:
                                return 'Sun';
                              default:
                                return '';
                            }
                          },
                          getTextStyles: (value) =>
                              TextStyle(color: Colors.black, fontSize: 10),
                        ),
                        leftTitles: SideTitles(
                          interval: 2000,
                          showTitles: true,
                          getTitles: (value) {
                            return '${value.toInt()}';
                          },
                        ),
                      ),
                      axisTitleData: FlAxisTitleData(
                          leftTitle: AxisTitle(
                              showTitle: false, titleText: 'Steps', margin: 2),
                          bottomTitle: AxisTitle(
                              showTitle: true,
                              margin: 8,
                              titleText: 'Steps',
                              textStyle:
                                  TextStyle(fontSize: 22, color: Colors.black),
                              textAlign: TextAlign.center)),
                      gridData: FlGridData(
                        show: true,
                        drawHorizontalLine: true,
                        drawVerticalLine: true,
                        horizontalInterval: 1.5,
                        verticalInterval: 400,
                        checkToShowHorizontalLine: (value) {
                          return value.toInt() == 0;
                        },
                        checkToShowVerticalLine: (value) {
                          return value.toInt() == 0;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
