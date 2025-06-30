// lib/features/book_finder/data/repositories/book_repository_impl.dart
import 'package:backbaseassignment/data/datasource/local_datasource.dart';
import 'package:backbaseassignment/data/datasource/remote_datasource.dart';
import 'package:backbaseassignment/data/model/book_detail_model.dart';
import 'package:backbaseassignment/domain/entities/book.dart';
import 'package:backbaseassignment/domain/entities/book_detail.dart';
import 'package:backbaseassignment/domain/repositories/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  BookRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Book>> searchBooks(String query, int page) async {
    final bookModels = await remoteDataSource.searchBooks(query, page);
    return bookModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<BookDetail> getBookDetails(String key) async {
    final bookDetailModel = await remoteDataSource.getBookDetails(key);
    return bookDetailModel.toEntity(); // Convert model to entity
  }

  @override
  Future<void> saveBook(BookDetail book) async {
    await localDataSource.saveBook(book);
  }

  @override
  Future<bool> isBookSaved(String key) async {
    return localDataSource.isBookSaved(key);
  }

  @override
  Future<List<BookDetail>> getSavedBooks() async {
    return localDataSource.getSavedBooks();
  }
}