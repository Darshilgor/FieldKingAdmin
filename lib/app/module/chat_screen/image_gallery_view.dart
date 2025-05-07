import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:get/get.dart';

class ImageGalleryView extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;

  const ImageGalleryView({
    Key? key,
    required this.imageUrls,
    required this.initialIndex,
  }) : super(key: key);

  @override
  State<ImageGalleryView> createState() => _ImageGalleryViewState();
}

class _ImageGalleryViewState extends State<ImageGalleryView> {
  late PageController _controller;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _controller = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: PageView.builder(
          controller: _controller,
          itemCount: widget.imageUrls.length,
          onPageChanged: (index) => setState(() => currentIndex = index),
          itemBuilder: (context, index) {
            return Center(
              child: ExtendedImage.network(
                widget.imageUrls[index],
                fit: BoxFit.contain,
                mode: ExtendedImageMode.gesture,
                cache: true,
              ),
            );
          },
        ),
      ),
    );
  }
}
