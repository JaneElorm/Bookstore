import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app_final/book_model.dart';

Future<List<Book>> fetchBooks() async {
  try {
    final querySnapshot = await FirebaseFirestore.instance.collection('Books').get();
    return querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>; // Explicitly cast to Map<String, dynamic>
      return Book.fromMap(data);
    }).toList();
  } catch (e) {
    print('Error fetching books: $e');
    return []; // Return an empty list on error
  }
}
