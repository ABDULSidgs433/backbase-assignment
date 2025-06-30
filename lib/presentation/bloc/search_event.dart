abstract class SearchEvent {}

class SearchQueryChanged extends SearchEvent {
  final String query;
  SearchQueryChanged(this.query);
}

class LoadMore extends SearchEvent {}

class Refresh extends SearchEvent {}