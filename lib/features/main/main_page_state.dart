import 'package:medium_app_ui/shared/error/flutter_error.dart';
import 'package:medium_app_ui/shared/state/app_state.dart';

class MainPageState implements BaseState<List<Article>> {
  const MainPageState({
    this.data = const [],
    this.error,
    this.isLoading = false,
  });

  @override
  final List<Article> data; //if we tried to log in

  @override
  final FlutterError error;

  @override
  final bool isLoading;

  MainPageState copyWith({
    final List<Article> data,
    final FlutterError error,
    final bool isLoading,
  }) {
    return MainPageState(
      data: data ?? this.data,
      error: error ?? this.error,
      isLoading: isLoading,
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data,
        'error': error,
        'isLoading': isLoading,
      };
}

class Article {
  const Article({
    this.title,
    this.category,
    this.author,
    this.date,
    this.readTime,
  });

  final String title;
  final String category;
  final String author;
  final String date;
  final String readTime;

  Article copyWith({
    final String title,
    final String category,
    final String author,
    final String date,
    final String readTime,
  }) {
    return Article(
      title: title ?? this.title,
      category: category ?? this.category,
      author: author ?? this.author,
      date: date ?? this.date,
      readTime: readTime ?? this.readTime,
    );
  }

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      category: json['category'],
      author: json['author'],
      date: json['date'],
      readTime: json['readTime'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'category': category,
        'author': author,
        'date': date,
        'readTime': readTime,
      };
}
