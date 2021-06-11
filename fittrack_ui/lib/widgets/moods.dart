import 'package:flutter/material.dart';

class MyMoods extends StatefulWidget {
  @override
  _MyMoodsState createState() => _MyMoodsState();
}

class _MyMoodsState extends State<MyMoods> {
  // このクラスはホームページ上部に5つの顔文字を表示しています
  // 該当する今日の体調を5段階で評価してもらうためです
  // 該当する体調の顔文字の色をつけ、ユーザにフィードバックしています
  // isSelectedはその5つの顔文字のどれが選択されているかを表します
  // 一つだけtrueになり、あとがfalseになるように実装します
  List<bool> isSelected = [
    true, // とても気分が悪い
    false, // 気分が悪い
    false, // 通常通り
    false, // 元気だ
    false, // とても元気だ
  ];
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
