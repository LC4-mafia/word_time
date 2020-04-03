
import 'package:flutter/material.dart';
import 'package:word_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setupWorldTime() async {

    WorldTime instance = WorldTime(flag: 'germany.png', location: 'Berlin', url: 'Europe/Berlin');
    await instance.getTime();

    // sending the data to the home screen after loading them
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'time': instance.time,
      'flag': instance.flag,
      'isDayTime': instance.isDayTime
      }
    );
  }

  @override
  void initState() {
   
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.blue[900],
      body: Center(

        //SpinKit-'name of animation' 
        // adds animation while loading the data from the web
        child: SpinKitCircle(
          color: Colors.white,
          size: 50.0,
        )
      )
    );
  }
}