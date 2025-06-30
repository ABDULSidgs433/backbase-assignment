import 'package:backbaseassignment/domain/entities/book.dart';
import 'package:backbaseassignment/domain/entities/book_detail.dart';

abstract class BookRepository {
  Future<List<Book>> searchBooks(String query, int page, int pagesize);
  Future<BookDetail> getBookDetails(String key);
  Future<void> saveBook(BookDetail book);
  Future<bool> isBookSaved(String key);
  Future<List<BookDetail>> getSavedBooks();
}
