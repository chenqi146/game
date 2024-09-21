import 'package:flutter/material.dart';

class PlayerAvatar extends StatelessWidget {
  final String avatarUrl;
  final String playerName;
  final double avatarSize;
  final double fontSize;
  final VoidCallback? onTap;
  final bool isSelected;
  final Widget? selectedOverlay;

  const PlayerAvatar({
    Key? key,
    required this.avatarUrl,
    required this.playerName,
    this.avatarSize = 48.0,
    this.fontSize = 10.0,
    this.onTap,
    this.isSelected = false,
    this.selectedOverlay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(avatarUrl),
                  radius: avatarSize / 2,
                ),
              ),
              if (isSelected && selectedOverlay != null)
                selectedOverlay!,
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          playerName,
          style: TextStyle(fontSize: fontSize),
        ),
      ],
    );
  }
}
