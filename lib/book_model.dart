class Book {
  final String id;
  final String title;
  final String author;
  final String price;
  final String imageUrl;
  final String rating;
  final String bookDescription;
  final String audioUrl;
  final String file;
  final int pages;
  

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.bookDescription,
    required this.audioUrl,
    required this.file,
    required this.pages,
  });

  factory Book.fromMap(Map<String, dynamic> data) {
    return Book(
      id: data['id'] ?? 'Unknown ID',
      title: data['titles'] ?? 'Unknown Title', // Changed 'title' to 'titles'
      author: data['author'] ?? 'Unknown Author',
      price: data['price'] ?? 'GH₵ 261',
      imageUrl: data['image_url'] ?? 'default_image_url',
      rating: data['ratings'] ?? 'No Rating', // Changed 'rating' to 'ratings'
      bookDescription: data['book_description'] ?? 'No Description',
      audioUrl: data['audio_url'] ?? 'No Audio URL',
      file: data['file'] ?? 'No File',
      pages: data['pages'] ?? 234,
    );
  }
}
