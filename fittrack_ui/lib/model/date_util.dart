import 'package:intl/intl.dart';

class DateUtil {
  static List<String> weekDay = ["月", "火", "水", "木", "金", "土", "日"];

  static String elapsedTime(DateTime past) {
    var today = DateTime.now().toLocal();
    var duration = today.difference(past);
    var d;
    d = duration.inDays;
    if (d > 365) {
      int year = (d / 365).toInt();
      return "$year年前";
    } else if (d > 0) {
      return "$d日前";
    }
    d = duration.inHours;
    if (d > 0) {
      return "$d時間前";
    }
    d = duration.inMinutes;
    if (d > 0) {
      return "$d分前";
    }
    d = duration.inSeconds;
    if (d > 0) {
      return "$d秒前";
    }
    return "";
  }

  //文字列からDateTimeへ変換する
  static DateTime toDateTime(String strDate) {
    if (strDate == null) return null;
    return DateTime.parse(strDate).toLocal();
  }

  //メッセージのフキダシ横に表示する用の投稿日のフォーマット
  static String formatForMessage(DateTime past) {
    var today = DateTime.now().toLocal();

    // 分の表示は２桁にする
    String minute = DateFormat('mm').format(past).toString();
    if (past.year == today.year) {
      //同日の場合、時:分 で表示
      if (past.month == today.month && past.day == today.day)
        return "${past.hour}:$minute";
      //同年の場合、月/日 時:分 で表示
      else
        return "${past.month}/${past.day} ${past.hour}:$minute";
      //年が違う場合、年/月/日 時:分 で表示
    } else {
      return "${past.year}/${past.month}/${past.day}\n${past.hour}:$minute";
    }
  }

  // 指定した時間に変更する
  static DateTime changeTime(DateTime dateTime,
      {int hour = 0, int minute = 0, seconds = 0}) {
    return DateTime(
        dateTime.year, dateTime.month, dateTime.day, hour, minute, seconds);
  }

  static String formatForRequest(DateTime d) {
    return "${d.year}年${d.month}月${d.day}日(${weekDay[d.weekday - 1]}) ${d.hour}:00";
  }

  static String formatForNoteComment(DateTime d) {
    return "${d.year}年${d.month}月${d.day}日 ${d.hour}:00";
  }

  static String formatMDWH(DateTime d) {
    return "${d.month}月${d.day}日(${weekDay[d.weekday - 1]}) ${d.hour}:00";
  }
}
