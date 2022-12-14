import 'package:library_base/utils/date_util.dart';
import 'package:library_base/utils/object_util.dart';

class QuoteWs {

  String? coin_code;
  double? quote;
  double? change_percent;
  double? change_amount;
  String? time;

  int get id => _getIdTs();

  int _getIdTs() {
    int ts = ((DateUtil.getDateMsByTimeStr(time ?? '') ?? 0) / 1000).floor();
    return ts;
  }

  QuoteWs({
    this.coin_code,
    this.quote,
    this.time,
  });

  QuoteWs.fromJson(Map<String, dynamic> jsonMap) {
    coin_code = jsonMap['coin_code'];
    quote = jsonMap['quote'] ?? 0;
    change_amount = jsonMap['change_amount'] ?? 0;
    change_percent = jsonMap['change_percent'] ?? 0;
    time = jsonMap['time'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = new Map<String, dynamic>();
    jsonMap['coin_code'] = this.coin_code;
    jsonMap['quote'] = this.quote;
    jsonMap['time'] = this.time;

    return jsonMap;
  }

  static List<QuoteWs>? fromJsonList(List<dynamic> mapList) {
    if (ObjectUtil.isEmptyList(mapList)) {
      return null;
    }

    List<QuoteWs> items = [];
    for(Map<String, dynamic> map in mapList) {
      items.add(QuoteWs.fromJson(map));
    }
    return items;
  }
}
