import 'package:intl/intl.dart';

class DateUtil {
  static String timeStr(String createTime) {
    final past =
    DateTime.parse(createTime.substring(0, createTime.indexOf('.')));
    final now = DateTime.now();

    var msFormat = new DateFormat('HH:mm');
    var ymdFormat = new DateFormat('yyyy/MM/dd');

    final timeDiff = now.difference(past);
    if (timeDiff.inDays == 0) {
      //今天
      if (timeDiff.inHours < 1) {
        if (timeDiff.inMinutes < 1) {
          return '刚刚';
        } else {
          return '${timeDiff.inMinutes}分钟前';
        }
      } else {
        return '${timeDiff.inHours}小时前';
      }
    } else if (timeDiff.inDays == 1) {
      //昨天
      return '昨天 ${msFormat.format(past)}';
    } else if (timeDiff.inDays == 2) {
      //前天
      return '前天 ${msFormat.format(past)}';
    } else {
      return ymdFormat.format(past) + ' ' + msFormat.format(past);
    }
  }
}
