import 'package:backbaseassignment/domain/core/failure.dart';
import 'package:backbaseassignment/domain/entities/book.dart';
import 'package:backbaseassignment/domain/repositories/book_repository.dart';

class SearchBooks {
  final BookRepository repository;
  SearchBooks(this.repository);
  Future<List<Book>> call(String query, int page, int pagesize) async {
    return await repository.searchBooks(query, page, pagesize);
  }
}
