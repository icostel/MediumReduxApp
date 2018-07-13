import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medium_app_ui/shared/ui/drawer_header.dart';
import 'package:medium_app_ui/shared/ui/menu_items.dart';

class MediumDrawer extends StatelessWidget {
  const MediumDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Scrollbar(
              child: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    floating: false,
                    delegate: PersistentHeaderDelegate(
                      minHeight: 240,
                      maxHeight: 240,
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        alignment: Alignment.centerLeft,
                        color: Colors.white,
                        child: const Header(),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(menuItems),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
