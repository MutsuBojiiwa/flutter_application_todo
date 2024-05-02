import 'package:flutter/material.dart';
import 'todoAdd.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Todo一覧'),
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
  List<String> todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 800,
          child: ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.only(
                  top: 10,
                  right: 40,
                  bottom: 0,
                  left: 40,
                ),
                child: ListTile(
                  onTap: () {
                    _showDialog(context, todoList[index]).then((value) {
                      if (value != null) {
                        // ダイアログで入力された値を処理する
                        setState(() {
                          todoList[index] = value;
                        });
                      }
                    });
                  },
                  title: Text(todoList[index]),
                  trailing: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        todoList.removeAt(index);
                      });
                    },
                    child: const Icon(Icons.delete),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // "push"で新規画面に遷移
          // リスト追加画面から渡される値を受け取る
          final newTodoText = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              // 遷移先の画面としてリスト追加画面を指定
              return TodoAddPage();
            }),
          );
          if (newTodoText != null) {
            // キャンセルした場合は newTodoText が null となる
            setState(() {
              // リスト追加
              todoList.add(newTodoText);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

Future<String?> _showDialog(BuildContext context, String todoText) async {
  // ダイアログを表示し、入力された値を取得するためにFutureを使用する
  return await showDialog<String?>(
    context: context,
    builder: (BuildContext context) {
      // ダイアログ内でテキストフィールドを制御するコントローラーを作成する
      TextEditingController controller = TextEditingController(text: todoText);

      return GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Dialog(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ダイアログ内にテキストフィールドを表示する
                TextField(
                  controller: controller,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // 更新ボタンが押された時、ダイアログを閉じて入力された値を返す
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, controller.text);
                      },
                      child: const Text('更新'),
                    ),
                    // キャンセルボタンが押された時、ダイアログを閉じる
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('キャンセル'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
