import 'package:medium_app_ui/shared/state/app_state.dart';
import 'package:redux_epics/redux_epics.dart';

class FlutterError {
  FlutterError(Object object, [this.stackTrace])
      : error = object is Error ? object : null,
        exception = object is Exception ? object : null,
        message = object is String ? object : null;

  const FlutterError._({
    this.error,
    this.exception,
    this.message,
    this.stackTrace,
  });

  final Error error;
  final Exception exception;
  final String message;
  final dynamic stackTrace;

  static Future<T> tryAsync<T>(EpicStore<AppState> store,
      Future<T> Function() body, T Function(FlutterError) onError) async {
    try {
      return await body();
    } catch (error, stack) {
      final flutterError = FlutterError._(
        error: error is Error ? error : null,
        exception: error is Exception ? error : null,
        message: error is String ? error : null,
        stackTrace: stack,
      );
      return onError(flutterError);
    }
  }

  @override
  String toString() => (error ?? exception ?? message ?? '').toString();
}
