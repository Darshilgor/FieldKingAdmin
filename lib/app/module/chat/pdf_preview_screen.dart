import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart'; // <-- import this

class PdfPreviewScreen extends StatelessWidget {
  final File pdfFile;
  final Future<void> Function() onSend;

  const PdfPreviewScreen({
    Key? key,
    required this.pdfFile,
    required this.onSend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview PDF'),
        actions: [
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: onSend,
          ),
        ],
      ),
      body: PDFView(
        filePath: pdfFile.path,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: true,
        pageFling: true,
      ),
    );
  }
}





///
///
///
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';

// class MultiPdfPreviewScreen extends StatefulWidget {
//   final List<File> pdfFiles;
//   final Future<void> Function() onSend;

//   const MultiPdfPreviewScreen({
//     Key? key,
//     required this.pdfFiles,
//     required this.onSend,
//   }) : super(key: key);

//   @override
//   _MultiPdfPreviewScreenState createState() => _MultiPdfPreviewScreenState();
// }

// class _MultiPdfPreviewScreenState extends State<MultiPdfPreviewScreen> {
//   PageController _pageController = PageController();
//   int currentIndex = 0;

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Preview PDF ${currentIndex + 1}/${widget.pdfFiles.length}'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.send),
//             onPressed: widget.onSend,
//           ),
//         ],
//       ),
//       body: PageView.builder(
//         controller: _pageController,
//         itemCount: widget.pdfFiles.length,
//         onPageChanged: (index) {
//           setState(() {
//             currentIndex = index;
//           });
//         },
//         itemBuilder: (context, index) {
//           return PDFView(
//             filePath: widget.pdfFiles[index].path,
//             enableSwipe: true,
//             swipeHorizontal: false,
//             autoSpacing: true,
//             pageFling: true,
//           );
//         },
//       ),
//     );
//   }
// }
