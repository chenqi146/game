import 'package:flutter/material.dart';

class UndercoverHomePage extends StatefulWidget {
  const UndercoverHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _UndercoverHomePage();
}

class _UndercoverHomePage extends State<UndercoverHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
                color: Colors.amber,
                child: const Text('创建房间'),
                onPressed: () {
                  Navigator.pushNamed(context, '/undercover/createRoom');
                }),
            const SizedBox(height: 16),
            MaterialButton(
              color: Colors.blue,
              child: const Text('加入房间'),
              onPressed: () {
              },
            )
          ],
        ),
      ),
    );
  }
}
