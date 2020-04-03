import 'package:flutter/material.dart';
import 'package:word_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  // supported countries 
  List<WorldTime> locations = [
    WorldTime(url: 'Africa/Accra', location: 'Accra', flag: 'ghana.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'germany.png'),
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png')
  ];

  void updateTime (index) async {

    WorldTime instance = locations[index];
    await instance.getTime();

    // go to home screen after getting the data
    Navigator.pop(context,{
      'location': instance.location,
      'time': instance.time,
      'flag': instance.flag,
      'isDayTime': instance.isDayTime
      }
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[200],

      // appBar displays choose location in the center
      appBar: AppBar(
        title:  Text('Choose Location'),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),

      // choose your locations from here
      body: ListView.builder(
        itemCount: locations.length,

        // builds the countries anytime
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(

              onTap: () {
                // passes the index of the current tapped country and time gets updated in home
                updateTime(index);
              },
              title: Text(locations[index].location),
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/${locations[index].flag}')
              ),

            ),
          );
        },
      )
    );
  }
}