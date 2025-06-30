// lib/injection_container.dart
import 'package:backbaseassignment/data/datasource/local_datasource.dart';
import 'package:backbaseassignment/data/datasource/local_datasource_impl.dart';
import 'package:backbaseassignment/data/datasource/remote_datasource.dart';
import 'package:backbaseassignment/data/datasource/remote_datasource_impl.dart';
import 'package:backbaseassignment/data/repositories/book_repository_impl.dart';
import 'package:backbaseassignment/domain/repositories/book_repository.dart';
import 'package:backbaseassignment/domain/usecases/search_books.dart';
import 'package:backbaseassignment/presentation/bloc/search_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;

Future<void> init() async {
  // Register HTTP Client
  getIt.registerLazySingleton<http.Client>(() => http.Client());
  
  // Data sources
  getIt.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(client: getIt<http.Client>()),
  );
  
  // Initialize and register local data source
  final localDataSource = LocalDataSourceImpl();
  await localDataSource.database; // Initialize database
  getIt.registerLazySingleton<LocalDataSource>(() => localDataSource);
  
  // Repository
  getIt.registerLazySingleton<BookRepository>(
    () => BookRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
    ),
  );
  
  // BLoCs
  getIt.registerFactory(
    () => SearchBloc(searchBooks: SearchBooks(getIt())),
  );
}