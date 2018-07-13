//the wrapper widget that exposes injections to the widget child
import 'package:flutter/widgets.dart';
import 'package:medium_app_ui/shared/providers/time_provider.dart';

class Injection extends InheritedWidget {
  const Injection({
    this.child,
    this.platform,
    this.timeProvider,
  }) : super(child: child);

  final TargetPlatform Function() platform;

  final TimeProvider timeProvider;
  final Widget child;

  DateTime get time => timeProvider.now;

  // access to `this` in the widget tree so we have access to stuff
  static Injection of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: Injection);

  // here we update the widget tree based on some members being changed
  // we currently don't change them, we init them once at setup
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
