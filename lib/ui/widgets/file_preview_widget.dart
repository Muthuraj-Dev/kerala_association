import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../common_widget/common_dialog.dart';

class FilePreviewWidget extends StatelessWidget {
  final RxString filePath;
  final RxString fileName;
  final RxString errorText;
  final RxBool isLoading;

  const FilePreviewWidget({
    Key? key,
    required this.filePath,
    required this.fileName,
    required this.errorText,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          final path = filePath.value;
          final name = fileName.value;

          // if (path.isEmpty || name.isEmpty) {
          //   return const SizedBox.shrink();
          // }

          if (path.isEmpty) {
            return const SizedBox.shrink();
          }

          final isPdf = path.toLowerCase().endsWith('.pdf');
          final isNetwork = path.startsWith("http");

          final cacheBypassPath =
              !isPdf && isNetwork
                  ? "$path?ts=${DateTime.now().millisecondsSinceEpoch}"
                  : path;

          return GestureDetector(
            onTap: () {
              if (isLoading.value) return;

              CommonDialog.showCustomDialog(
                content: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child:
                      isPdf
                          ? isNetwork
                              ? SfPdfViewer.network(path)
                              : SfPdfViewer.file(File(path))
                          : Center(
                            child: InteractiveViewer(
                              minScale: 0.5,
                              maxScale: 4,
                              child: CachedNetworkImage(
                                imageUrl: cacheBypassPath,
                                fit: BoxFit.contain,
                                placeholder:
                                    (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                errorWidget:
                                    (context, url, error) =>
                                        const Text('Failed to load image'),
                              ),
                            ),
                          ),
                ),
              );
            },

            /// 🔥 THUMBNAIL UI (like your photo)
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 92,
                height: 92,
                color: Colors.grey.shade100,
                child:
                    isPdf
                        ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.picture_as_pdf,
                              color: Colors.red,
                              size: 36,
                            ),
                            SizedBox(height: 4),
                            Text("PDF", style: TextStyle(fontSize: 10)),
                          ],
                        )
                        : CachedNetworkImage(
                          imageUrl: cacheBypassPath,
                          fit: BoxFit.cover,
                          placeholder:
                              (context, url) => const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                          errorWidget:
                              (context, url, error) =>
                                  const Icon(Icons.image_not_supported),
                        ),
              ),
            ),
          );
        }),

        /// 🔴 ERROR TEXT
        Obx(() {
          final error = errorText.value;
          return error.isNotEmpty
              ? Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  error,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              )
              : const SizedBox.shrink();
        }),
      ],
    );
  }
}
