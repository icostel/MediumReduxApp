import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medium_app_ui/shared/device_info.dart';

class OrientationWidget extends StatelessWidget {
  const OrientationWidget({
    Key key,
    @required this.primaryChild,
    @required this.secondaryChild,
    this.divider,
  }) : super(key: key);

  final Widget primaryChild;
  final Widget secondaryChild;
  final Widget divider;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.landscape) {
          return Row(
            children: [
              Flexible(
                flex: 1,
                child: primaryChild,
              ),
              // on phone landscape we don't use the secondary child
              if (isTablet(context) || isWeb || isDesktop) ...[
                divider ??
                    Container(
                      margin: EdgeInsets.all(8.0),
                      color: Colors.black12,
                      width: 2,
                    ),
                Flexible(
                  flex: 2,
                  child: secondaryChild,
                ),
              ],
            ],
          );
        } else {
          return primaryChild;
        }
      },
    );
  }
}
