import 'package:http/http.dart';
import 'dart:convert';
// import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  bool isDayTime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      var string = data['datetime'].substring(0, 10) +
          ' ' +
          data['datetime'].substring(11, 19);
      DateTime todayDate = DateTime.parse(string);

      isDayTime = int.parse(data['datetime'].substring(11, 13)) > 6 &&
              int.parse(data['datetime'].substring(11, 13)) < 16
          ? true
          : false;
      time = formatDate(todayDate, [hh, ':', nn, ' ', am]);
    } catch (e) {
      print('caught error $e');
      time = 'No Connection';
    }
  }
}
