import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MaterialApp(
      home: Tasbeh(),
    ));

class Tasbeh extends StatefulWidget {
  const Tasbeh({Key? key}) : super(key: key);

  @override
  State<Tasbeh> createState() => _TasbehState();
}

class _TasbehState extends State<Tasbeh> {
  final AudioPlayer pla = AudioPlayer();
  int number = 0;
  int qiymat = 0;
  int qoldiq = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      number = prefs.getInt('number') ?? 0;
      qiymat = prefs.getInt('qiymat') ?? 0;
    });
  }

  _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('number', number);
    await prefs.setInt('qiymat', qiymat);
  }

  void puls() {
    setState(() {
      number++;
      qiymat = (number / 33).floor();
      _saveData();
    });
  }

  void clear() {
    setState(() {
      number = 0;
      qiymat = 0;
      qoldiq = 0;
      _saveData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Center(
                child: CircleAvatar(
                  radius: 120,
                  backgroundColor: Colors.green,
                  backgroundImage: AssetImage('rasm/aaa.png'),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      puls();
                      pla.play(AssetSource('sound.mp3'));
                      pla.seek(Duration.zero);
                    },
                    child: Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0.2, 0.2),
                            blurRadius: 5,
                            spreadRadius: 7,
                            color: Color.fromARGB(255, 145, 216, 145),
                          )
                        ],
                        color: Color.fromARGB(255, 103, 215, 116),
                        borderRadius: BorderRadius.circular(150),
                      ),
                      child: Center(
                        child: Text(
                          '$number',
                          style: TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$qiymat /33',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 100),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    backgroundColor: Colors.green,
                                    title: Text(
                                        "Malumotni o'chirichni xoxlaysizmi ?"),
                                    actions: [
                                      SizedBox(height: 40),
                                      Center(
                                        child: Text(
                                          "$number",
                                          style: TextStyle(
                                              fontSize: 50,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("Yo'q")),
                                          TextButton(
                                              onPressed: () {
                                                clear();
                                                Navigator.pop(context);
                                              },
                                              child: Text("Ha"))
                                        ],
                                      )
                                    ],
                                  ));
                        },
                        icon: Icon(
                          Icons.refresh,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
