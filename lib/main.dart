import 'package:fitnessquest/today_menu.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitnessQuest',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'FitnessQuest'),
        '/today_menu': (context) => const TodayMenu(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('FitnessQuest'),
      ),
      body: Container(
        color: Colors.white,
        child:Center(
          child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('本日のトレーニングを表示して、運動しよう！'),
            SizedBox(height: 20), // 20ピクセルの縦マージンを追加
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/today_menu');
              },
              child: Text('今日のトレーニングを表示'),
            ),
          ],
          ),
        ),
      ),
    );
  }
}
