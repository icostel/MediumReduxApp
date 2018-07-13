import 'package:flutter/material.dart';
import 'package:medium_app_ui/shared/ui/drawer_item.dart';

final menuItems = const [
  DrawerItem("Home"),
  DrawerItem("Audio"),
  DrawerItem("Bookmarks"),
  DrawerItem("Interests"),
  Divider(),
  DrawerItem(
    "Become a member",
    isHighlight: true,
  ),
  Divider(),
  DrawerItem("New Story"),
  DrawerItem("Stats"),
  DrawerItem("Drafts"),
];
