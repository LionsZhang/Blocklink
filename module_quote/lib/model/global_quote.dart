
import 'package:library_base/utils/object_util.dart';

class GlobalQuote {
  String? code;
  String? zh_name;
  num? quote ;
  num? change_amount;
  num? change_percent;
  num? posX;
  num? posY;

  GlobalQuote({
    this.code,
    this.zh_name,
    this.quote,
    this.change_amount,
    this.change_percent,
  });

  GlobalQuote.fromJson(Map<String, dynamic> jsonMap) {
    code = jsonMap['code'];
    zh_name = jsonMap['zh_name'];
    quote = jsonMap['quote'];
    change_amount = jsonMap['change_amount'];
    change_percent = jsonMap['change_percent'];
    var position = jsonMap['position'];
    if (position != null) {
      posX = position['x'] ?? 0;
      posY = position['y'] ?? 0;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = new Map<String, dynamic>();
    jsonMap['code'] = this.code;
    jsonMap['zh_name'] = this.zh_name;
    jsonMap['quote'] = this.quote;
    jsonMap['change_amount'] = this.change_amount;
    jsonMap['change_percent'] = this.change_percent;

    return jsonMap;
  }

  static List<GlobalQuote>? fromJsonList(List<dynamic> mapList) {
    if (ObjectUtil.isEmptyList(mapList)) {
      return null;
    }

    List<GlobalQuote> items = [];
    for(Map<String, dynamic> map in mapList) {
      items.add(GlobalQuote.fromJson(map));
    }
    return items;
  }
}
