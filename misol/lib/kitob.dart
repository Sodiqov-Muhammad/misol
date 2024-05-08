import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
void main() => runApp(MaterialApp(
      home: Kitob(),
    ));
class Kitob extends StatefulWidget {
  const Kitob({super.key});

  @override
  State<Kitob> createState() => _KitobState();
}

class _KitobState extends State<Kitob> {
  final nom = BorderRadius.circular(15);
  final nom2 =
      TextStyle(fontSize: 25,  color: Colors.black);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 155, 226, 157),
        body: Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => A()));
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(4, 3),
                          color:  Colors.green,
                          blurRadius: 5,
                          spreadRadius: 0.1)
                    ],
                    borderRadius: nom,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => A()));
                            });
                          },
                          child: Container(
                            width: 90,
                            height: 120,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('rasm/ribo.jpg'),
                                ),
                                borderRadius: nom),
                          ),
                        ),
                      ),
                      Text("Ribo axkomlari",
                      style: nom2,)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class A extends StatefulWidget {
  const A({super.key});

  @override
  State<A> createState() => _AState();
}

class _AState extends State<A> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: SfPdfViewer.asset('assets/ribo.pdf')),
    );
  }
}
