import 'package:flutter/material.dart';
import 'package:number_collect_app/parts/left_message_item.dart';
import '../parts/right_message_item.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF87ABE9),
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            RightMessageItem(text: '遊び方', width: 90),
            LeftMessageItem(text: 'ガチャを引こう!!', width: 300),
            LeftMessageItem(text: '数字をコンプリートしよう!', width: 300),
            RightMessageItem(text: '1日に何回引ける？', width: 200),
            LeftMessageItem(text: '1日10回まで引けるぞ', width: 200),
            LeftMessageItem(text: '動画を視聴することで', width: 200),
            LeftMessageItem(text: '引ける回数が増えるぞ', width: 200),
            RightMessageItem(text: '何種類あるの？', width: 200),
            LeftMessageItem(text: '全部で、100種類あるぞ', width: 250),
            LeftMessageItem(text: 'コンプリートしてみよう!!', width: 250),
          ],
        ),
      ),
    );
  }
}
