import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math'as math;

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
      home: Salom(),
    ));

class Salom extends StatefulWidget {
  const Salom({super.key});

  @override
  State<Salom> createState() => _SalomState();
}

class _SalomState extends State<Salom> {
  bool _hasPermission = false;
  @override 
  void initState() {
    // TODO: implement initState
    super.initState();
    _FetchbermissionStatus();
  }

  void _FetchbermissionStatus() {
    Permission.locationWhenInUse.status.then((status) {
      if (mounted) {
        setState(() {
          _hasPermission = (status == PermissionStatus.granted);
        });
      }
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 40, 155, 82),
        body:
         Builder(builder: (context) {
          if (_hasPermission) {
            return _builderCompass(); 
          } else {
            return _builderpermissionsheep();
           }
               }),
      ),
    );
  }

  Widget _builderCompass() {
    return StreamBuilder<CompassEvent>(stream: 
    FlutterCompass.events,
    builder: (context, snapshot){
    if (snapshot.hasError){
      return Text("Error reading heading: ${snapshot.error}");
    }
    if (snapshot.connectionState == ConnectionState.waiting){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
     double? direction = snapshot.data!.heading;
     if (direction == null){
      return Center(
        child: Text("Device does not have sensors"),
      );
     }
      return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Transform.rotate(
            angle: direction * (math.pi / 180) * -1,
             child: Image.asset("rasm/compasss.png"),
          ),
        ),
      ),
    );
    });
   
  }

  Widget _builderpermissionsheep() {
    return Center(
      child: ElevatedButton(onPressed: (){
        Permission.locationWhenInUse.request().then((value) {
          _FetchbermissionStatus();
          print('bos');
        } );
      }, child: 
      Text("Put this plese"))
    );
  }
}
