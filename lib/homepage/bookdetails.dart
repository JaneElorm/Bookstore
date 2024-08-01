import 'dart:ui'; // Import for BackdropFilter
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app_final/book_model.dart';
import 'package:mobile_app_final/homepage/playbookscreen.dart';
import 'package:mobile_app_final/homepage/readbookscreen.dart';

class BookDetailsPage extends StatefulWidget {
  final String bookId;

  BookDetailsPage({required this.bookId});

  @override
  _BookDetailsPageState createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  late Future<Book> _book;

  @override
  void initState() {
    super.initState();
    _book = fetchBookDetails(widget.bookId);
  }

  Future<Book> fetchBookDetails(String bookId) async {
    final docSnapshot = await FirebaseFirestore.instance.collection('books').doc(bookId).get();
    return Book.fromMap(docSnapshot.data() as Map<String, dynamic>);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Book>(
        future: _book,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Book not found'));
          } else {
            final book = snapshot.data!;
            return Stack(
              children: [
                // Background image with blur effect
                Positioned.fill(
                  child: Image.network(
                    book.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      color: Colors.black.withOpacity(0.5), // Darken the image
                    ),
                  ),
                ),
                Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    title: Text(book.title),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    actions: [
                      IconButton(
                        icon: Icon(Icons.favorite_border),
                        onPressed: () {
                          // Add your logic for favorite button
                        },
                      ),
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            book.imageUrl,
                            height: 200,
                          ),
                          SizedBox(height: 16),
                          Text(
                            book.title,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Author: ${book.author}',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Publishing and graphic design, Lorem ipsum is a placeholder text commonly used.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildDetailColumn('Rating', book.rating.toString()),
                                    _buildDetailColumn('Pages', book.pages.toString()),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'About Book',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      book.bookDescription,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ReadBookScreen(
                                              bookTitle: book.title,
                                              pdfPath: book.file,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text('Read Book'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.brown[300], // Button color
                                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => PlayBookScreen(
                                              bookTitle: book.title,
                                              
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text('Play Book'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.brown, // Button color
                                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildDetailColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }
}
