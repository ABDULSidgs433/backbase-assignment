 class BookDetail {
      final String key;
      final String title;
      final String? description;
      final List<String> authors;
      final String? coverUrl;
      BookDetail({required this.key, required this.title, required this.description, required this.authors, this.coverUrl});
    }