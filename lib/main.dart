import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:medium_app_ui/features/main/main_page.dart';
import 'package:medium_app_ui/shared/injection/injections.dart';
import 'package:medium_app_ui/shared/providers/time_provider.dart';
import 'package:medium_app_ui/shared/state/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: Store<AppState>(
        appStateReducer,
        initialState: const AppState(),
        middleware: [
          EpicMiddleware(allEpics()),
        ],
      ),
      child: Injection(
        child: MaterialApp(
          title: 'Home',
          home: const MainPage(),
          debugShowCheckedModeBanner: false,
        ),
        platform: () => defaultTargetPlatform,
        timeProvider: const TimeProvider(),
      ),
    );
  }
}
