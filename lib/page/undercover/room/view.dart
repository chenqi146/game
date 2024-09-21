import 'package:flutter/material.dart';
import 'package:game/common/base/base_stateful_page.dart';
import 'package:game/common/utils/utils.dart';
import 'package:game/components/icon_avatar.dart';
import 'package:game/service/user_service.dart';
import 'package:get/get.dart';

import 'logic.dart';

class RoomPage extends BaseStatefulPage<RoomLogic> {
  RoomPage({Key? key}) : super(key: key);

  @override
  RoomLogic createRawLogic() {
    return RoomLogic();
  }

  @override
  State<StatefulWidget> createState() => _RoomPage();
}

class _RoomPage extends State<RoomPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.logic.initData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('房间: ${widget.logic.roomId}'),
              centerTitle: true,
            ),
            body: Column(
              children: [
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    childAspectRatio: 1.0,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                  ),
                  itemCount: widget.logic.room.value.users.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PlayerAvatar(
                      avatarUrl: Utils.getAvatarUrl(widget.logic.room.value.users[index].avatar),
                      playerName: widget.logic.room.value.users[index].nickname,
                      onTap: () => print('Player ${index + 1} tapped'),
                      selectedOverlay: Container(
                        width: 48.0,
                        height: 48.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
