import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GachaListScreen extends StatefulWidget {
  const GachaListScreen({Key? key}) : super(key: key);

  @override
  _GachaListScreenState createState() => _GachaListScreenState();
}

class _GachaListScreenState extends State<GachaListScreen> {
  List<String> numberList = ['0'];
  List<int> numberIntList = [0];

  @override
  void initState() {
    super.initState();
    getRandomNumber();
  }

  void getRandomNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      numberList = prefs.getStringList('list') ?? [];
      numberIntList = numberList.map(int.parse).toList();
      numberIntList.sort();
      numberIntList.toSet().toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF87ABE9),
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        elevation: 0,
        title: const Text(
          '数字リスト',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10,
        ),
        itemCount: numberIntList.length,
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: Text(
              '${numberIntList[index]}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }
}
