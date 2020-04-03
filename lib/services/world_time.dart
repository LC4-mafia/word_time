import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location;  // location name for the UI
  String url;       // location url for api endpoint
  String flag;      // url to an asset flag icon
  String time;      // the time for the named location
  bool isDayTime;   // true if it's day and false if it's night
  // bool errors;      // true if any error occured
  // String errorMsg;  // corresponding error msg

  WorldTime({ this.location, this.flag, this.url});

  Future<void> getTime() async {
    try{
      Response response =  await get('http://worldtimeapi.org/api/timezone/$url');
      Map data;
      
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        data =  json.decode(response.body);
      } else {
        // If that call was not successful, throw an error.
      //  errors = true;
        throw Exception('Failed to load post');

      }
      // print(data);
      // print(data['timezone']);
      // print(data['datetime']);

      // getting properties from data
      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      // converting the raw data to a date time object
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      // true if day time and false if night time
      isDayTime = now.hour > 6 && now.hour < 22 ? true : false;

      // print('$dateTime');
      // print('$offset');


      // set the time property
      time = DateFormat().add_jm().format(now);

    }catch(e){
     // errorMsg = e.toString();
     print(e.toString());

    }
    
  }
}