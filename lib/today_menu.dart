import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

class TodayMenu extends StatefulWidget {
  const TodayMenu({super.key});

  @override
  State<TodayMenu> createState() => _TodayMenuState();
}

class _TodayMenuState extends State<TodayMenu> {
  // メニューデータ
  Map<String, dynamic>? menuData;
  // 選択されたメニュー
  Map<String, dynamic>? selectedMenu;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMenuData();
  }

  //
  Future<void> loadMenuData() async {
    try {
      // メニューデータを読み込む
      final String response = await rootBundle.loadString('assets/data/menu.json');
      final data = json.decode(response);
      
      // ランダムにメニューを選択
      final random = Random();
      final menus = data['daily_menus'] as List;
      final randomMenu = menus[random.nextInt(menus.length)];
      
      // メニューデータを更新
      setState(() {
        //ロード成功
        menuData = data;
        selectedMenu = randomMenu;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        //ロード失敗
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('本日のトレーニング'),
      ),
      body: Container(
        color: Colors.white,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // メニュー名を表示
                    Text(
                      selectedMenu?['name'] ?? 'トレーニング',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                    //余白を設定  
                    SizedBox(height: 20),
                    //見出し
                    Text(
                      'エクササイズ一覧',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    //余白を設定
                    SizedBox(height: 10),
                    //取得したメニューデータを元にリスト表示
                    Expanded(
                      child: ListView.builder(
                        itemCount: (selectedMenu?['exercises'] as List?)?.length ?? 0,
                        itemBuilder: (context, index) {
                          final exercise = selectedMenu?['exercises'][index];
                          return Card(
                            margin: EdgeInsets.only(bottom: 10),
                            elevation: 2,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue[100],
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[800],
                                  ),
                                ),
                              ),
                              title: Text(
                                exercise['name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text('${exercise['sets']}セット × ${exercise['reps']}回'),
                              trailing: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  exercise['weight'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[800],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
