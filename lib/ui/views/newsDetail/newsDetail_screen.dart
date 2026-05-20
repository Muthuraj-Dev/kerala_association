import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/model/news_list_response.dart';
import '../../../core/res/colors.dart';
import '../notification/notification_screen.dart';
import 'newsDetail_controller.dart';

class NewsDetailScreen extends StatefulWidget {
  final NewsData? news;
  final String? newsId;

  const NewsDetailScreen({
    super.key,
    this.news,
    this.newsId,
  });

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  late final NewsDetailController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.find<NewsDetailController>();

    final id = widget.news?.newsID ??
        int.tryParse(widget.newsId ?? '');

    if (id != null) {
      controller.fetchNewsDetail(id);
    } else {
      debugPrint("❌ Invalid news ID");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("News Detail")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = controller.detail.value;
        if (data == null) {
          return const Center(child: Text("No data found"));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// IMAGE
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(12),
              //   child: Image.network(
              //     data.storyImageURL ?? '',
              //     //  height: 180,
              //     width: double.infinity,
              //     fit: BoxFit.cover,
              //     errorBuilder:
              //         (_, __, ___) => const SizedBox(
              //           height: 180,
              //           child: Icon(Icons.image, size: 40),
              //         ),
              //   ),
              // ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  fadeInDuration: const Duration(milliseconds: 250),
                  fadeOutDuration: const Duration(milliseconds: 100),
                  imageUrl: data.storyImageURL ?? '',
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,

                  placeholder: (context, url) => Container(
                    height: 180,
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),

                  errorWidget: (context, url, error) => const SizedBox(
                    height: 180,
                    child: Icon(Icons.broken_image, size: 40),
                  ),
                ),
              ),


              const SizedBox(height: 16),

              /// TITLE
              Text(
                data.storyPreviewContent ?? '',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 6),

              /// SOURCE + DATE
              Text(
                "${data.source ?? ''} • ${controller.formatNewsDetailDate(data.publishedOn)}",
                style: const TextStyle(fontSize: 12, color: Color(0xff505050)),
              ),

              const SizedBox(height: 20),

              /// HTML CONTENT
              // Html(
              //   data: data.storyFullContent ?? '',
              //   style: {
              //     "p": Style(
              //       fontSize: FontSize(16),
              //       lineHeight: LineHeight(1.5),
              //     ),
              //     "h3": Style(
              //       fontSize: FontSize(18),
              //       fontWeight: FontWeight.bold,
              //     ),
              //   },
              // ),
              Html(
                data: data.storyFullContent ?? '',
                style: {
                  "body": Style(
                    margin: Margins.zero,
                    padding: HtmlPaddings.zero,
                    fontSize: FontSize(16),
                    lineHeight: LineHeight(1.6),
                    color: AppColor.black,
                  ),

                  "p": Style(margin: Margins.only(bottom: 12)),

                  "h2": Style(
                    fontSize: FontSize(20),
                    fontWeight: FontWeight.bold,
                    margin: Margins.symmetric(vertical: 12),
                  ),

                  "h3": Style(
                    fontSize: FontSize(18),
                    fontWeight: FontWeight.w600,
                    margin: Margins.symmetric(vertical: 10),
                  ),

                  "ul": Style(
                    padding: HtmlPaddings.only(left: 18),
                    margin: Margins.symmetric(vertical: 10),
                  ),

                  "li": Style(margin: Margins.only(bottom: 6)),

                  "strong": Style(fontWeight: FontWeight.w600),

                  "hr": Style(
                    margin: Margins.symmetric(vertical: 16),
                    border: const Border(
                      bottom: BorderSide(color: Color(0xFFE0E0E0)),
                    ),
                  ),
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
