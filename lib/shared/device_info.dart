import 'dart:io';

import 'package:flutter/widgets.dart';

bool isLandscape(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return size.width > size.height;
}

//in web the 0 and 0.0 are the same, in dart there are not
const bool isWeb = identical(0, 0.0);

bool get isDesktop =>
    Platform.isWindows ||
    Platform.isMacOS ||
    Platform.isLinux ||
    Platform.isFuchsia;

// number 600 here is a common breakpoint for a typical 7-inch tablet.
bool isTablet(BuildContext context) =>
    MediaQuery.of(context).size.shortestSide > 600;
