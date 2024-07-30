import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: PrayerTimesApp(),
  ));
}

class PrayerTimesApp extends StatefulWidget {
  const PrayerTimesApp({super.key});

  @override
  State<PrayerTimesApp> createState() => _PrayerTimesAppState();
}

class _PrayerTimesAppState extends State<PrayerTimesApp> {
  bool isBomdodNotified = false;
  bool isQuyoshNotified = false;
  bool isPeshinNotified = false;
  bool isAsrNotified = false;
  bool isShomNotified = false;
  bool isHuftonNotified = false;

  String location = "";
  String date = "";
  String weekday = "";
  String bomdod = "";
  String quyosh = "";
  String peshin = "";
  String asr = "";
  String shom = "";
  String hufton = "";

  final TextEditingController inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchPrayerTimes("Toshkent");
  }

  void fetchPrayerTimes(String city) async {
    final response = await http.get(Uri.parse("https://islomapi.uz/api/present/day?region=$city"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        location = data["region"];
        date = data["date"];
        weekday = data["weekday"];
        bomdod = data["times"]["tong_saharlik"];
        quyosh = data["times"]["quyosh"];
        peshin = data["times"]["peshin"];
        asr = data["times"]["asr"];
        shom = data["times"]["shom_iftor"];
        hufton = data["times"]["hufton"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: inputController,
                        style: TextStyle(color: Colors.green),
                        decoration: InputDecoration(
                          focusColor: Colors.green,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          suffixIcon: IconButton(
                            onPressed: () {
                              fetchPrayerTimes(inputController.text);
                            },
                            icon: Icon(Icons.search),
                          ),
                          hintText: 'Shahar nomi',
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on, color: Colors.green, size: 30),
                        Text(
                          '$location',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                        )
                      ],
                    ),
                    SizedBox(height: 50),
                    Namoz1()
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildPrayerTimeRow("Bomdod", bomdod, Icons.nightlight, isBomdodNotified, () {
                      setState(() {
                        isBomdodNotified = !isBomdodNotified;
                      });
                    }),
                    buildPrayerTimeRow("Quyosh  ", quyosh, Icons.sunny, isQuyoshNotified, () {
                      setState(() {
                        isQuyoshNotified = !isQuyoshNotified;
                      });
                    }),
                    buildPrayerTimeRow("Peshin   ", peshin, Icons.sunny, isPeshinNotified, () {
                      setState(() {
                        isPeshinNotified = !isPeshinNotified;
                      });
                    }),
                    buildPrayerTimeRow("Asr        ", asr, Icons.sunny, isAsrNotified, () {
                      setState(() {
                        isAsrNotified = !isAsrNotified;
                      });
                    }),
                    buildPrayerTimeRow("Shom    ", shom, Icons.nightlight, isShomNotified, () {
                      setState(() {
                        isShomNotified = !isShomNotified;
                      });
                    }),
                    buildPrayerTimeRow("Hufton  ", hufton, Icons.nightlight, isHuftonNotified, () {
                      setState(() {
                        isHuftonNotified = !isHuftonNotified;
                      });
                    }),
                  ],
                ),
              )
           
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPrayerTimeRow(String title, String time, IconData icon, bool isNotified, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(border: Border.all(color: Colors.green, width: 1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Icon(icon, size: 30, color: Colors.green),
              SizedBox(width: 20),
              Text(
                '$title  ',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '$time',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              SizedBox(width: 10),
              IconButton(
                onPressed: onPressed,
                icon: Icon(
                  isNotified ? Icons.notifications_on : Icons.notifications_off,
                  color: Colors.green,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Namoz1 extends StatefulWidget {
  const Namoz1({super.key});

  @override
  State<Namoz1> createState() => _Namoz1State();
}

class _Namoz1State extends State<Namoz1> {
  String gregorianDay = "";
  String gregorianYear = "";
  String hijriDay = "";
  String hijriYear = "";

  @override
  void initState() {
    super.initState();
    fetchDates();
  }

  void fetchDates() async {
    final response = await http.get(Uri.parse("https://api.aladhan.com/v1/timingsByAddress/present?address=Tashkent"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)["data"]["date"];
      setState(() {
        gregorianDay = data["gregorian"]["day"];
        gregorianYear = data["gregorian"]["year"];
        hijriDay = data["hijri"]["day"];
        hijriYear = data["hijri"]["year"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildDateContainer(gregorianDay, gregorianYear),
        buildDateContainer(hijriDay, hijriYear),
      ],
    );
  }

  Widget buildDateContainer(String day, String year) {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 1),
            color: Color.fromARGB(100, 100, 100, 10),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              "$day",
              style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              "$year",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

