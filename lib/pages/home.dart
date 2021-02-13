import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    String bgImage = data['isDayTime'] == true
        ? 'assets/day.jpg'
        : data['isDayTime'] == false
            ? 'assets/night.jpg'
            : 'assets/404.jpg';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(bgImage), fit: BoxFit.fitHeight)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'location': result['location'],
                        'flag': result['flag'],
                        'time': result['time'],
                        'isDayTime': result['isDayTime']
                      };
                    });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(color: Colors.grey[300]),
                  )),
              SizedBox(height: 10.0),
              Text(
                data['time'],
                style: TextStyle(
                    fontSize: data['time'] == 'No Connection' ? 20.0 : 60.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (data['time'] != 'No Connection')
                    Text(
                      data['location'],
                      style: TextStyle(
                          fontSize: 30.0,
                          letterSpacing: 2.0,
                          color: Colors.white),
                    )
                  else
                    Icon(
                      Icons.cloud_off,
                      color: Colors.white,
                      size: 50.0,
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
