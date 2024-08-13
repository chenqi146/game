import 'package:flutter/material.dart';

class RoomCreatePage extends StatefulWidget {
  const RoomCreatePage({super.key});

  @override
  State<StatefulWidget> createState() => _RoomCreatePage();
}

class _RoomCreatePage extends State<RoomCreatePage> {
  int playerNum = 4;

  // 卧底数量
  int undercoverNum = 1;

  // 平民数量
  int civiliansNum = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('创建房间'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 12),
              const Text('玩家数量'),
              const SizedBox(width: 12),
              Slider(
                  value: playerNum.toDouble(),
                  min: 3,
                  max: 12,
                  onChanged: (value) {
                    setState(() {
                      playerNum = value.toInt();
                      if (playerNum >= 6 && playerNum < 10) {
                        undercoverNum = 2;
                      } else if (playerNum >= 10) {
                        undercoverNum = 3;
                      } else {
                        undercoverNum = 1;
                      }
                      civiliansNum = playerNum - undercoverNum;
                    });
                  }),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const SizedBox(height: 16),
                  const Text('玩家数量'),
                  Text('$playerNum'),
                ],
              ),
              const SizedBox(width: 16),
               Column(
                children: [
                  const SizedBox(height: 16),
                  const Text('卧底数量'),
                  Text('$undercoverNum'),
                ],
              ),
              const SizedBox(width: 16),
              Column(
                children: [
                  const SizedBox(height: 16),
                  const Text('平民数量'),
                  Text('$civiliansNum'),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          MaterialButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RoomPage(
                    roomId: '123456',
                    playerNum: playerNum,
                    undercoverNum: undercoverNum,
                    civiliansNum: civiliansNum,
                  ),
                ),
              );
            },
            child: const Text('创建房间'),
          ),
        ],
      ),
    );
  }
}

class RoomPage extends StatefulWidget {
  final String roomId;

  final int playerNum;

  // 卧底数量
  final int undercoverNum;

  // 平民数量
  final int civiliansNum;

  const RoomPage(
      {super.key,
      required this.roomId,
      required this.playerNum,
      required this.undercoverNum,
      required this.civiliansNum});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
