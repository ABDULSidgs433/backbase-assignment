
import 'dart:convert';
import 'package:backbaseassignment/data/model/book_model.dart';
import 'package:http/http.dart' as http;
import '../model/book_detail_model.dart';
import 'remote_datasource.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  static const String _baseUrl = 'https://openlibrary.org';
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<List<BookModel>> searchBooks(String query, int page) async {
    try {
      final response = await client.get(
        Uri.parse('$_baseUrl/search.json?title=$query&page=$page'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final docs = data['docs'] as List;
        return docs.map((json) => BookModel.fromJson(json)).toList();
      } else {
        throw ServerException(
            'Failed to search books: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException('Network error: $e');
    }
  }

  @override
  Future<BookDetailModel> getBookDetails(String key) async {
    try {
      final response = await client.get(
        Uri.parse('$_baseUrl$key.json'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return BookDetailModel.fromJson(data);
      } else {
        throw ServerException(
            'Failed to get book details: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException('Network error: $e');
    }
  }
}

class ServerException implements Exception {
  final String message;
  ServerException(this.message);
  
  @override
  String toString() => 'ServerException: $message';
}