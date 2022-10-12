import 'package:flutter/material.dart';
import 'package:number_collect_app/screen/gacha_list_screen.dart';
import 'package:number_collect_app/screen/gacha_result_screen.dart';
import 'package:number_collect_app/screen/info_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int count = 10;

  @override
  void initState() {
    super.initState();
    readCount();
  }

  void readCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      count = prefs.getInt('count')!;
    });
  }

  void checkGacha() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? timestamp = prefs.getInt('time');
    if (timestamp == null) {
      setState(() {
        count--;
      });
      gacha();
      writeDay();
      writeGacha();
    } else {
      DateTime before = DateTime.fromMillisecondsSinceEpoch(timestamp);
      DateTime now = DateTime.now();
      final yesterday = now.add(const Duration(days: -1));
      if (before.difference(yesterday).inHours >= 0) {
        setState(() {
          count = prefs.getInt('count') ?? 10;
        });
        writeDay();
        writeGacha();
      } else {
        setState(() {
          count = 10;
          writeGacha();
        });
        writeDay();
      }

      if (count > 0) {
        setState(() {
          count--;
        });
        writeGacha();
        gacha();
      } else {
        //TODO 広告を表示させる。
        print('広告をみてください');
        dialog();
      }
    }
  }

  void dialog() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Center(
            child: Column(
              children: const [
                Text('１日の上限回数に達しました'),
                Text('また明日引いてください'),
              ],
            ),
          ),
        );
      },
    );
  }

  void gacha() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Image.asset('assets/images/gacha.gif'),
        );
      },
    );
    Future.delayed(const Duration(seconds: 6), () {
      writeDay();
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const GachaResultScreen(),
        ),
      );
    });
  }

  void writeDay() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    prefs.setInt('time', timestamp);
  }

  void writeGacha() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('count', count);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF87ABE9),
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        elevation: 0,
        actions: [
          IconButton(
            iconSize: 35,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GachaListScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.description,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '数字コレクション',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                // onPressed: checkGacha,
                onPressed: () {
                  // gacha();
                  checkGacha();
                },
                child: const Text(
                  'ガチャる',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Text(
              'あと$count回',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InfoScreen(),
            ),
          );
        },
        child: const Text(
          '？',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
