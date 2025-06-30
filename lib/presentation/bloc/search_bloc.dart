import 'package:backbaseassignment/domain/usecases/search_books.dart';
import 'package:backbaseassignment/presentation/bloc/search_event.dart';
import 'package:backbaseassignment/presentation/bloc/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/core/constance.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchBooks searchBooks;
  int page = 1;
  String currentQuery = '';

  SearchBloc({required this.searchBooks}) : super(SearchInitial()) {
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<LoadMore>(_onLoadMore);
    on<Refresh>(_onRefresh);
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    currentQuery = event.query;
    page = 1;
    emit(SearchLoading());

    try {
      final books = await searchBooks(currentQuery, page);
      emit(SearchSuccess(books: books, hasReachedMax: books.isEmpty));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  Future<void> _onLoadMore(
    LoadMore event,
    Emitter<SearchState> emit,
  ) async {
    if (state is! SearchSuccess) return;

    final currentState = state as SearchSuccess;
    if (currentState.hasReachedMax) return;

    page++;
    emit(SearchLoading(previousBooks: currentState.books));

    try {
      final newBooks =
          await searchBooks(currentQuery, page, Constance().PAGESIZE);
      if (newBooks.isEmpty) {
        emit(SearchSuccess(
          books: currentState.books,
          hasReachedMax: true,
        ));
      } else {
        emit(SearchSuccess(
          books: [...currentState.books, ...newBooks],
          hasReachedMax: false,
        ));
      }
    } catch (e) {
      emit(SearchError(e.toString()));
      emit(currentState); // Revert to previous state on error
    }
  }

  Future<void> _onRefresh(
    Refresh event,
    Emitter<SearchState> emit,
  ) async {
    if (currentQuery.isEmpty) {
      emit(SearchInitial());
      return;
    }

    page = 1;
    emit(SearchLoading());

    try {
      final books = await searchBooks(currentQuery, page, 10);
      emit(SearchSuccess(books: books, hasReachedMax: books.isEmpty));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}
