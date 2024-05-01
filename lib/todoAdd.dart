import 'package:flutter/material.dart';

class TodoAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Todo追加'),
      ),

      body: Container(
        padding: const EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const TextField(),
            const SizedBox(height: 8,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  //処理を書く
                },
                child: const Text('Todo追加'),
              ),
            ),
            const SizedBox(height: 8,),
            SizedBox(
              width: double.infinity,
              child: TextButton(onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('キャンセル'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}