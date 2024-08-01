import 'package:flutter/material.dart';
import 'package:mobile_app_final/book_model.dart';
import 'package:mobile_app_final/homepage/bestselling.dart';
import 'package:mobile_app_final/homepage/booklistpage.dart';
import 'package:mobile_app_final/nav_bar/cart.dart';
import 'package:mobile_app_final/nav_bar/explore.dart';
import 'package:mobile_app_final/nav_bar/saved.dart';
import 'package:mobile_app_final/homepage/bookdetails.dart';
import 'package:mobile_app_final/homepage/profilepage.dart';
import 'package:mobile_app_final/services/book_services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
    HomeScreen(),
    ExplorePage(),
    SavedPage(),
    CartPage(),
    BestsellingPage(),
    
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bookstore',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.person_outline),
            color: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'EXPLORE',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: 'SAVED',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_checkout),
            label: 'CART',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
      future: fetchBooks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No books available'));
        } else {
          final books = snapshot.data!;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchBar(),
                  SizedBox(height: 16),
                  FilterButtons(),
                  SizedBox(height: 16),
                  SectionTitle(
                    title: 'Best selling books',
                    onSeeAllPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookListPage(title: 'Best Selling Books', books: books),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  BookList(books: books),
                  SizedBox(height: 16),
                  SectionTitle(
                    title: 'Trending Now',
                    onSeeAllPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookListPage(title: 'Trending Now', books: books),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  BookList(books: books),
                  SizedBox(height: 16),
                  SectionTitle(
                    title: 'Popular books',
                    onSeeAllPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookListPage(title: 'Popular Books', books: books),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  BookList(books: books),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class BookList extends StatelessWidget {
  final List<Book> books;

  BookList({required this.books});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return BookCard(
            id: book.id,
            title: book.title,
            author: book.author,
            price: book.price,
            image: book.imageUrl,
            rating: book.rating,
            pages: book.pages,
          );
        },
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FilterButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FilterButton(title: 'For you', isSelected: true),
        FilterButton(title: 'E-books', isSelected: false),
        FilterButton(title: 'Audiobooks', isSelected: false),
      ],
    );
  }
}

class FilterButton extends StatelessWidget {
  final String title;
  final bool isSelected;

  FilterButton({required this.title, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.brown : Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAllPressed;

  SectionTitle({required this.title, required this.onSeeAllPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: onSeeAllPressed,
          child: Text(
            'See all',
            style: TextStyle(color: Colors.orange),
          ),
        ),
      ],
    );
  }
}

class BookCard extends StatelessWidget {
  final String id;
  final String title;
  final String author;
  final String price;
  final String image;
  final String rating;
  final int pages;

  BookCard({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    required this.image,
    required this.rating,
    required this.pages,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailsPage(bookId: id),
          ),
        );
      },
      child: Container(
        width: 120,
        margin: EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8),
            Container(
              constraints: BoxConstraints(maxWidth: 120),
              child: Text(
                title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 4),
            Text(
              author,
              style: TextStyle(fontSize: 12, color: Colors.grey),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              price,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
