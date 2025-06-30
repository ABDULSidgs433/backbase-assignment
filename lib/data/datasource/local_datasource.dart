import 'package:backbaseassignment/domain/entities/book_detail.dart';

abstract class LocalDataSource {
  Future<void> saveBook(BookDetail book);
  Future<bool> isBookSaved(String key);
  Future<List<BookDetail>> getSavedBooks();
}