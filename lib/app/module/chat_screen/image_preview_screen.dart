import 'package:field_king_admin/packages/config.dart';
import 'package:field_king_admin/services/app_color/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:get/get_core/src/get_main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImagePreviewScreen extends StatelessWidget {
  final List<File> imageFiles;
  final VoidCallback onSend;

  ImagePreviewScreen({
    Key? key,
    required this.imageFiles,
    required this.onSend,
  }) : super(key: key);

  PageController pageController = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.whiteColor,
          body: Container(
            color: Colors.black,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: imageFiles.length,
                      onPageChanged: (index) {
                        currentIndex = index;
                      },
                      itemBuilder: (context, index) {
                        return Center(
                          child: Container(
                            width: Get.width,
                            child: Image.file(
                              imageFiles[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: imageFiles.length != 1,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      SmoothPageIndicator(
                        controller: pageController,
                        count: imageFiles.length,
                        effect: WormEffect(
                          activeDotColor: Colors.white,
                          dotColor: Colors.grey,
                          dotHeight: 10,
                          dotWidth: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                    right: 20,
                    top: 10,
                    left: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(
                            13,
                          ),
                          child: Icon(
                            Icons.close,
                            size: 25,
                            color: AppColor.whiteColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: onSend,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(
                            13,
                          ),
                          child: Icon(
                            Icons.send,
                            color: AppColor.whiteColor,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
