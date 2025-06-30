import 'package:backbaseassignment/data/model/book_detail_model.dart';
import 'package:backbaseassignment/data/model/book_model.dart';

abstract class RemoteDataSource {
      Future<List<BookModel>> searchBooks(String query, int page);
      Future<BookDetailModel> getBookDetails(String key);
    }