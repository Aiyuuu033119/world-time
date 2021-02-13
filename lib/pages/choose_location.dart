import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> location = [
    WorldTime(url: 'Asia/Manila', location: 'Manila', flag: 'ph.png'),
    WorldTime(url: 'Asia/Tokyo', location: 'Tokyo', flag: 'jp.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'ks.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'idn.png'),
    WorldTime(url: 'Europe/Paris', location: 'Paris', flag: 'fr.png'),
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Berlin', flag: 'gm.png'),
    WorldTime(url: 'Europe/Athens', location: 'Athens', flag: 'gc.png'),
  ];

  void updateTime(index) async {
    WorldTime instance = location[index];
    await instance.getTime();
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose Location'),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                updateTime(index);
              },
              title: Text(location[index].location),
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/${location[index].flag}'),
              ),
            ),
          );
        },
        itemCount: location.length,
      ),
    );
  }
}
