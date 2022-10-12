import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:shared_preferences/shared_preferences.dart';

class GachaResultScreen extends StatefulWidget {
  const GachaResultScreen({Key? key}) : super(key: key);

  @override
  _GachaResultScreenState createState() => _GachaResultScreenState();
}

class _GachaResultScreenState extends State<GachaResultScreen> {
  int number = 0;
  List<String> numberList = [];

  @override
  void initState() {
    super.initState();
    getRandomNumber();
  }

  void getRandomNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    numberList = prefs.getStringList('list') ?? [];
    var random = math.Random();
    setState(() {
      number = random.nextInt(100);
    });
    numberList.add(number.toString());
    readNumber(numberList);
  }

  void readNumber(List<String> numberList) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('list', numberList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF87ABE9),
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '獲得した数字',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              '$number',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
