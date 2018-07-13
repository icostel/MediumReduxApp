import 'package:medium_app_ui/features/main/main_page_reducer.dart';
import 'package:medium_app_ui/features/main/main_page_state.dart';
import 'package:medium_app_ui/shared/error/flutter_error.dart';
import 'package:redux_epics/redux_epics.dart';

class AppState {
  const AppState({
    this.mainPageState = const MainPageState(),
    //add more feature states
  });

  final MainPageState mainPageState;

  AppState copyWith({
    MainPageState mainPageState,
  }) {
    return AppState(
      mainPageState: mainPageState ?? this.mainPageState,
    );
  }
}

Epic<AppState> allEpics() => combineEpics(
      [
        getArticlesEpic(),
        //add more reducer epics here
      ],
    );

AppState appStateReducer(AppState state, dynamic action) {
  return AppState(
    mainPageState: mainPageReducer(state.mainPageState, action),
    //add more reducers that alter the feature states
  );
}

//to be used on all sub-states of the AppState
abstract class BaseState<T> {
  T get data;

  FlutterError get error;

  bool get isLoading;
}
