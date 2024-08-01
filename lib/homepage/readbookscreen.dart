import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class ReadBookScreen extends StatefulWidget {
  final String bookTitle;
  final String pdfPath;

  const ReadBookScreen({super.key, required this.bookTitle, required this.pdfPath});
  static const routeName = '/read-book-screen';

  @override
  _ReadBookScreenState createState() => _ReadBookScreenState();
}

class _ReadBookScreenState extends State<ReadBookScreen> {
  late Future<String> _localPdfPath;

  @override
  void initState() {
    super.initState();
    _localPdfPath = _downloadPdf(widget.pdfPath);
  }

  Future<String> _downloadPdf(String url) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/temp.pdf');
    try {
      await Dio().download(url, file.path);
      return file.path;
    } catch (e) {
      print('Download failed: $e');
      throw Exception('Failed to download PDF');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bookTitle),
        backgroundColor: Colors.brown, // Customize as needed
      ),
      body: FutureBuilder<String>(
        future: _localPdfPath,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No book found'));
          } else {
            final pdfPath = snapshot.data!;
            return PDFView(
              filePath: pdfPath,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: false,
              pageFling: false,
              onError: (error) {
                print(error.toString());
              },
              onRender: (_pages) {
                print('Document rendered with $_pages pages');
              },
              onViewCreated: (PDFViewController pdfViewController) {},
              onPageChanged: (int? page, int? total) {
                print('Page changed: $page/$total');
              },
            );
          }
        },
      ),
    );
  }
}
