import 'package:backbaseassignment/domain/entities/book.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {
  final List<Book> previousBooks;
  SearchLoading({this.previousBooks = const []});
}

class SearchSuccess extends SearchState {
  final List<Book> books;
  final bool hasReachedMax;
  SearchSuccess({required this.books, this.hasReachedMax = false});
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}