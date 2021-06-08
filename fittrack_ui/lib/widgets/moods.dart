//Todo 稼働していないコメントは削除してもらえるとレビューしやすいです。
import 'package:flutter/material.dart';

class MyMoods extends StatefulWidget {
  @override
  _MyMoodsState createState() => _MyMoodsState();
}

class _MyMoodsState extends State<MyMoods> {
  //Todo が何を表しているのか読み進めないと分からないので、コメントで補足するなり、Mapで値を設定してリスト展開するなどして分かりやすくしてもらえると助かります。
  List<bool> isSelected = [true, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ToggleButtons(
        selectedBorderColor: Colors.purple,
        renderBorder: false,
        fillColor: Colors.transparent,
        children: [
          Icon(
            Icons.sentiment_very_dissatisfied,
            size: 36,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 12.0,
            ),
            child: Icon(
              Icons.sentiment_dissatisfied,
              size: 36,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 12.0,
            ),
            child: Icon(
              Icons.sentiment_neutral,
              size: 36,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 12.0,
            ),
            child: Icon(
              Icons.sentiment_satisfied,
              size: 36,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 12.0,
            ),
            child: Icon(
              Icons.sentiment_very_satisfied,
              size: 36,
            ),
          ),
        ],
        isSelected: isSelected,
        onPressed: (int index) {
          setState(() {
            isSelected = [false, false, false, false, false];
            isSelected[index] = !isSelected[index];
          });
        },
      ),
    );
  }
}
