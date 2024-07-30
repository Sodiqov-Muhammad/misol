// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:misol/noti.dart';

//  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//  void main(){
//   runApp( const MyApp());
//  }
//  class MyApp extends StatelessWidget {
//   const MyApp({super.key});
  

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//    Noti.initialize(flutterLocalNotificationsPlugin);

//   }


//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//         begin: Alignment.topLeft,
//          end: Alignment.bottomRight,
//           colors: [
//           Color(0xFF3ac3cb),
//           Color(0xFFf85187)])),
//       child: Scaffold(
//         body: Center(
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.blue,
//               borderRadius: BorderRadius.circular(10)
//             ),
//             width: 200,
//             height: 80,
//             child: ElevatedButton(onPressed: (){

//               Noti.showbigtextNotification(title: "Massage title", body: "your long body", fln: flutterLocalNotificationsPlugin);
//             }, child: Text("click"),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue
//             ),),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

import 'compass.dart';

import 'namoz.dart';

import 'tasbeh.dart';

import 'kitob.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Duo(),
    ));

class Duo extends StatefulWidget {
  const Duo({super.key});

  @override
  State<Duo> createState() => _DuoState();
}

class _DuoState extends State<Duo> {
  int tanlanganindex = 0;
  static List<Widget> images = <Widget>[
    PrayerTimesApp(),
   Tasbeh(), Salom(),  Kitob(),];
  void bos(int index) {
    setState(() {
      tanlanganindex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawerScrimColor: Colors.yellow,
      body: Center(
        child: images.elementAt(tanlanganindex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              label: 'Namoz vaqtlari ' ,
              icon: Icon(
                FlutterIslamicIcons.islam,
                size: 30,
              ),
              backgroundColor: Color.fromARGB(255, 175, 243, 177)),
          BottomNavigationBarItem(
              label: 'Tasbeh',
              icon: Icon(
                FlutterIslamicIcons.tasbih3,
                size: 30,
              ),
              backgroundColor: const Color.fromARGB(255, 160, 249, 163)),
          BottomNavigationBarItem(
              label: 'Compost',
              icon: Icon(
              FlutterIslamicIcons.qibla2,
                size: 30,
              ),
              backgroundColor: const Color.fromARGB(255, 132, 242, 135)),
              BottomNavigationBarItem(
                label: 'Kitoblar',
                icon: Icon( FlutterIslamicIcons.quran2,),
                backgroundColor: Color.fromARGB(255, 94, 241, 99)
                )
        ],
        currentIndex: tanlanganindex,
        selectedItemColor: Colors.black,
        onTap: bos,
      ),
      
    );
  }
}
