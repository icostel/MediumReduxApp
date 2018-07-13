import 'dart:convert';

import 'package:medium_app_ui/features/main/main_page_state.dart';
import 'package:medium_app_ui/shared/error/flutter_error.dart';
import 'package:medium_app_ui/shared/mock_data/mocked_articles.dart';
import 'package:medium_app_ui/shared/state/app_state.dart';
import 'package:redux_epics/redux_epics.dart';

abstract class _MainAction {}

class FetchArticlesAction implements _MainAction {
  const FetchArticlesAction();
}

class SuccessFetchingAction implements _MainAction {
  const SuccessFetchingAction(this.articles);

  final List<Article> articles;
}

class ErrorFetchingAction implements _MainAction {
  const ErrorFetchingAction(this.error);

  final FlutterError error;
}

MainPageState mainPageReducer(MainPageState oldState, dynamic action) {
  // used for filtering so that this reducer focuses only on this base action
  if (action is _MainAction) {
    if (action is FetchArticlesAction) {
      return oldState.copyWith(
        isLoading: true,
        error: null,
        data: const [],
      );
    }
    if (action is SuccessFetchingAction) {
      return oldState.copyWith(
        isLoading: false,
        error: null,
        data: action.articles,
      );
    }
    if (action is ErrorFetchingAction) {
      return oldState.copyWith(
        isLoading: false,
        error: action.error,
        data: const [],
      );
    }
  }

  return oldState;
}

//normally this would have a http/firebase/whatever client passed to it
dynamic getArticlesEpic() {
  return (Stream<dynamic> actions, EpicStore<AppState> store) {
    return actions.where((action) => action is _MainAction).asyncMap(
          (action) => FlutterError.tryAsync(
            store,
            () async {
              // fake API response, muhauahuah
              return Future.delayed(const Duration(seconds: 3), () {
                final List<dynamic> decodedResponse =
                    json.decode(mocked_articles_response)['articles'];
                final articles = decodedResponse
                    .map((item) => Article.fromJson(item))
                    .toList();
                return SuccessFetchingAction(articles);
              });
            },
            (error) => ErrorFetchingAction(error),
          ),
        );
  };
}
