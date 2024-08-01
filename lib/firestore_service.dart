import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Book>> getBooks() {
    return _db.collection('books').snapshots().map(
      (snapshot) => snapshot.docs.map(
        (doc) => Book.fromFirestore(doc.data()),
      ).toList(),
    );
  }
}

class Book {
  final String title;
  final String author;
  final String price;
  final String image;
  final double rating;
  final int pages;

  Book({
    required this.title,
    required this.author,
    required this.price,
    required this.image,
    required this.rating,
    required this.pages,
  });

  factory Book.fromFirestore(Map<String, dynamic> data) {
    return Book(
      title: data['title'],
      author: data['author'],
      price: data['price'],
      image: data['image'],
      rating: data['rating'].toDouble(),
      pages: data['pages'],
    );
  }
}
