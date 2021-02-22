import 'dart:convert';

class Measurables {
  int id;
  Map<String, dynamic> measurables;
  bool isTicked;

  toMap() {
    String valueInDb = jsonEncode(measurables);
    var measurableMap = Map<String, dynamic>();

    measurableMap['id'] = id;
    measurableMap['measurable'] = valueInDb;
    measurableMap['isTicked'] = isTicked.toString();

    return measurableMap;
  }
}
