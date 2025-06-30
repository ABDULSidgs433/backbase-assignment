// lib/presentation/pages/search_page.dart
import 'package:backbaseassignment/domain/entities/book.dart';
import 'package:backbaseassignment/presentation/bloc/search_bloc.dart';
import 'package:backbaseassignment/presentation/bloc/search_event.dart';
import 'package:backbaseassignment/presentation/bloc/search_state.dart';
import 'package:backbaseassignment/presentation/pages/book_card.dart';
import 'package:backbaseassignment/presentation/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<SearchBloc>().add(LoadMore());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Finder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by title...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _performSearch,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (_) => _performSearch(),
            ),
            const SizedBox(height: 16),
            // Results Section
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading && state.previousBooks.isEmpty) {
      return const ShimmerLoading();
    }
                  return _buildStateContent(state);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _performSearch() {
    if (_searchController.text.trim().isEmpty) return;
    
    context.read<SearchBloc>().add(
      SearchQueryChanged(_searchController.text.trim()),
    );
  }

  Widget _buildStateContent(SearchState state) {
    if (state is SearchInitial) {
      return const Center(child: Text('Enter a book title to search'));
    } else if (state is SearchLoading) {
      if (state.previousBooks.isEmpty) {
        return const ShimmerLoading(); // Initial loading
      }
      return _buildBookList(state.previousBooks, isLoading: true);
    } else if (state is SearchError) {
      return Center(child: Text('Error: ${state.message}'));
    } else if (state is SearchSuccess) {
      if (state.books.isEmpty) {
        return const Center(child: Text('No books found'));
      }
      return RefreshIndicator(
        onRefresh: () async {
          context.read<SearchBloc>().add(Refresh());
        },
        child: _buildBookList(
          state.books,
          hasReachedMax: state.hasReachedMax,
        ),
      );
    }
    return Container(); // Fallback
  }

  Widget _buildBookList(List<Book> books, {
    bool hasReachedMax = true, 
    bool isLoading = false
  }) {
    final itemCount = books.length + (isLoading || !hasReachedMax ? 1 : 0);
    
    return ListView.builder(
      controller: _scrollController,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index < books.length) {
          return BookCard(book: books[index]);
        } else {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}