import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Column(
        children: [
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Colors.amber,
                  minWidth: 40,
                  height: 50,
                  onPressed: () {
                    Navigator.pushNamed(context, '/undercover');
                  },
                  child: const Text('我是卧底')),
              const SizedBox(width: 16),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: Colors.blue,
                minWidth: 40,
                height: 50,
                child: const Text('用户信息'),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 84),
        ],
      ),
    );
  }
}
