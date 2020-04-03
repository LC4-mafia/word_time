import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data: ModalRoute.of(context).settings.arguments;
    //print(data);

    // sets the bgImage; depends if its day or night
    String bgImage = data['isDayTime'] ? 'day.png' : 'night.png';

    // set the notif bgColor; light blue if day time and dark indigo if night
    Color bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo[800];

    // sets the text colors of the location and time
    Color txtColor = data['isDayTime'] ? Colors.white : Colors.black;

    // sets the icon colors; depends on day and night
    Color iconColor = data['isDayTime'] ? Colors.grey[300] : Colors.grey[800];
    
    return Scaffold(

      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(

          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover
            )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 120.0, 0.0, 0.0),
            child: Column(
              children: <Widget>[

                // do the edit location widget
                FlatButton.icon(
                  onPressed: () async {
                     dynamic result = await Navigator.pushNamed(context, '/location');
                    
                    // builds the home screen again after data is being taken from the api
                    // this is after the big asynchronous function that occured between the choose location_ 
                    // and the home screen

                    setState(() {
                      data = {
                        'time': result['time'],
                        'flag': result['flag'],
                        'isDayTime': result['isDayTime'],
                        'location': result['location']
                      };
                    });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: iconColor,
                  ),
                  label: Text(
                    'edit location',
                    style: TextStyle(
                      color: txtColor,
                    ),
                  ),
                  
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // puts the screen on screen 
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 28,
                        letterSpacing: 2.0,
                        color: txtColor
                      )
                    ),
                    // space between the location and the time 
                    SizedBox(height: 20),
                    // display the time on screen and beneath the location
                    

                  ],
                ),
                Text(
                      data['time'],
                      style: TextStyle(
                        fontSize: 66,
                        color: txtColor
                      )
                    )

                
              ],
            ),
          ),
        ),
      ),

    );
  }
}