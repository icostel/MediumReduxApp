import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medium_app_ui/shared/device_info.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem(
    this.text, {
    this.isHighlight = false,
  });

  final String text;
  final bool isHighlight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        bottom: 8,
        top: 8,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18.0,
          color: isHighlight ? Colors.teal : isWeb ? Colors.grey : Colors.black,
        ),
      ),
    );
  }
}
