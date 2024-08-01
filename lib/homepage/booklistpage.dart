import 'package:flutter/material.dart';
import 'package:mobile_app_final/book_model.dart';
import 'package:mobile_app_final/homepage/bestselling.dart';

class BookListPage extends StatelessWidget {
  final String title;
  final List<Book> books;

  BookListPage({required this.title, required this.books});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(25),
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return BookCard(
            id: book.id,
            title: book.title,
            author: book.author,
            price: book.price,
            image: book.imageUrl,
            rating: double.tryParse(book.rating) ?? 0.0,
            pages: book.pages,
          );
        },
      ),
    );
  }
}
