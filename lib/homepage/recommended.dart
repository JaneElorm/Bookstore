// import 'package:flutter/material.dart';
// // import 'package:mobile_app_final/homepage/Homepage.dart';
// // import 'package:mobile_app_final/nav_bar/cart.dart';
// // import 'package:mobile_app_final/nav_bar/explore.dart';
// // import 'package:mobile_app_final/nav_bar/saved.dart';
// import 'package:mobile_app_final/homepage/bookdetails.dart';

// class RecommendedPage extends StatefulWidget {
//   @override
//   _RecommendedPageState createState() => _RecommendedPageState();
// }

// class _RecommendedPageState extends State<RecommendedPage> {


//   void _onItemTapped(int index) {
//     setState(() {
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             icon: Icon(Icons.arrow_back),
//             color: Colors.black,
//             onPressed: () {},
//           ),
//         ],
//         title: Text(
//           'Trending',
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 16),
//               SearchBar(),
//               SizedBox(height: 16),
//               FilterButtons(),
//               SizedBox(height: 16),
//               // Add a grid view for book cards
//               GridView.builder(
//                 physics: NeverScrollableScrollPhysics(), // Prevent scrolling inside the grid view
//                 shrinkWrap: true, // Use only as much space as needed
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2, // Number of columns
//                   crossAxisSpacing: 16.0,
//                   mainAxisSpacing: 16.0,
//                   childAspectRatio: 0.7, // Adjust the ratio to make the cards look good
//                 ),
//                 itemCount: 10, // Replace with your actual item count
//                 itemBuilder: (context, index) {
//                   return BookCard(
//                     title: 'Book Title $index',
//                     author: 'Author $index',
//                     price: '\$20.00',
//                     image: 'images/img_06.webp',
//                     rating: 4.5,
//                     pages: 320,
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
      
//     );
//   }
// }

// class SearchBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.grey[200],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.search, color: Colors.grey),
//           SizedBox(width: 8),
//           Expanded(
//             child: TextField(
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 hintText: 'Search',
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FilterButtons extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         FilterButton(title: 'Romance', isSelected: true),
//         SizedBox(width: 8),
//         FilterButton(title: 'Horror', isSelected: false),
//         SizedBox(width: 8),
//         FilterButton(title: 'Fiction', isSelected: false),
//         SizedBox(width: 8),
//         FilterButton(title: 'Sci-Fi', isSelected: true),
//         SizedBox(width: 8),
//         FilterButton(title: 'Classics', isSelected: false),
//         SizedBox(width: 8),
//         FilterButton(title: 'Fantasy', isSelected: false),
//       ],
//     );
//   }
// }

// class FilterButton extends StatelessWidget {
//   final String title;
//   final bool isSelected;

//   FilterButton({required this.title, required this.isSelected});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//         color: isSelected ? Colors.brown : Colors.grey[200],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Text(
//         title,
//         style: TextStyle(
//           color: isSelected ? Colors.white : Colors.black,
//         ),
//       ),
//     );
//   }
// }

// class BookCard extends StatelessWidget {
//   final String title;
//   final String author;
//   final String price;
//   final String image;
//   final double rating;
//   final int pages;

//   BookCard({
//     required this.title,
//     required this.author,
//     required this.price,
//     required this.image,
//     required this.rating,
//     required this.pages,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => BookDetailsPage(
//               title: title,
//               author: author,
//               price: price,
//               image: image,
//               rating: rating,
//               pages: pages,
//             ),
//           ),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               spreadRadius: 1,
//               blurRadius: 5,
//               offset: Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               margin: EdgeInsets.all(8.0),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(5),
//                 child: Image.asset(
//                   image,
//                   height: 180,
//                   width: 120,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               title,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//               ),
//               textAlign: TextAlign.center,
//               overflow: TextOverflow.ellipsis,
//             ),
//             Text(
//               author,
//               textAlign: TextAlign.center,
//               overflow: TextOverflow.ellipsis,
//             ),
//             Text(
//               price,
//               style: TextStyle(
//                 color: Colors.brown,
//                 fontSize: 14,
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(5, (index) {
//                 return Icon(
//                   index < rating ? Icons.star : Icons.star_border,
//                   size: 16,
//                   color: Colors.brown,
//                 );
//               }),
//             ),
//             SizedBox(height: 8),
//           ],
//         ),
//       ),
//     );
//   }
// }
