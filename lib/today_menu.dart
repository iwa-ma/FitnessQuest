import 'package:flutter/material.dart';

class TodayMenu extends StatelessWidget {
  const TodayMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('本日のトレーニング'),
      ),
      body: Container(
        color: Colors.white,
        child:Center(
          child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('本日のトレーニング!'),
            SizedBox(height: 20), // 20ピクセルの縦マージン
          ]
          ),
        ),
      ),
    );
  }
}
