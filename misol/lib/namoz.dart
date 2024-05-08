import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;


void main() => runApp(MaterialApp(
      home: X(),
    ));

class X extends StatefulWidget {
  const X({super.key});

  @override
  State<X> createState() => _XState();
}

class _XState extends State<X> {
  TextEditingController input = TextEditingController();
  String joylashuv = '';
  String bomdod = '';
  String peshin = '';
  String asr = '';
  String shom = '';
  String hufton = '';
  String tong = '';
  String kun = '';
  String sana = '';
  String tun = '';
  String hij = '';
  String day = '';
  String year = '';
  String qiymat = '';
  void dataa(nom) async {
    String upi =
        'https://api.aladhan.com/v1/timingsByAddress/present?address=$nom';
    http.Response res = await http.get(Uri.parse(upi));
    Map malumot = jsonDecode(res.body);
    setState(() {
      bomdod = malumot['data']['timings']['Fajr'];
      tong = malumot['data']['timings']['Sunrise'];
      tun = malumot['data']['timings']['Midnight'];
      peshin = malumot['data']['timings']['Dhuhr'];
      asr = malumot['data']['timings']['Asr'];
      shom = malumot['data']['timings']['Maghrib'];
      hufton = malumot['data']['timings']['Isha'];
      sana = malumot['data']['date']['readable'];
      hij = malumot['data']['date']['hijri']['day'];
      day = malumot['data']['date']['hijri']['year'];
      kun = malumot['data']['date']['gregorian']['day'];
      year = malumot['data']['date']['gregorian']['year'];
      joylashuv = malumot['data']['meta']['timezone'];
      nom = qiymat;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataa('Tashkent');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 223, 244, 223),
          body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
                controller: input,
                style: TextStyle(color: Colors.green),
                decoration: InputDecoration(
                    focusColor: Colors.green,
                    border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(10)),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            dataa(input.text);
                            qiymat = input.text;
                          });
                        },
                        icon: Icon(Icons.search)),
                    hintText: 'Shaxar nomi')),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: Colors.green,
                size: 30,
              ),
              Text(
                '$joylashuv',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              )
            ],
          ),
          Text(
            '$sana',
            style: TextStyle(
                fontSize: 15, color: Colors.green, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.green, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '$kun',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          '$year',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.green, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '$hij',
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          '$day',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 50),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 350,
                child: Row(
                  children: [
                    Icon(
                      Icons.light_mode,
                      color: Colors.yellow,
                      size: 30,
                    ),
                    Text(
                      'Quyosh:/$tong',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 40),
                    Icon(
                      Icons.nightlight,
                      size: 20,
                      color: Colors.black,
                    ),
                    Text('Tun:/$tun',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.green,
                            fontWeight: FontWeight.w600))
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 1,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      offset: Offset(5, 4),
                      blurRadius: 1,
                      color: Color.fromARGB(175, 0, 0, 0))
                ]),
              ),
              SizedBox(height: 5),
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.nightlight,
                            size: 30,
                            color: Colors.black,
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Bomdod',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          )
                        ],
                      ),
                    ),
                    Text(
                      '$bomdod',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.sunny,
                            size: 29,
                            color: Colors.yellow,
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Peshin   ',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          )
                        ],
                      ),
                    ),
                    Text(
                      '$peshin',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.sunny,
                            size: 30,
                            color: Colors.yellow,
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Asr        ',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          )
                        ],
                      ),
                    ),
                    Text(
                      '$asr',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.nightlight,
                            size: 30,
                            color: Colors.black,
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Shom    ',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          )
                        ],
                      ),
                    ),
                    Text(
                      '$shom',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.nightlight,
                            size: 30,
                            color: Colors.black,
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Hufton  ',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          )
                        ],
                      ),
                    ),
                    Text(
                      '$hufton',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    )
                  ],
                ),
              )
            ],
          )
                ],
              )),
    );
  }
}
