import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kerala_association/core/res/colors.dart';
import 'package:kerala_association/ui/views/news/news_controller.dart';
import 'package:kerala_association/ui/views/newsDetail/newsDetail_screen.dart';

import '../dashboard/dashboard_controller.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final NewsController controller = Get.find();

  bool _handledNavigation = false;

  @override
  void initState() {
    super.initState();
    print("OPENING DETAIL FROM NEWS SCREEN");
    final dashboardController = Get.find<DashboardController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_handledNavigation) return; // ✅ prevent duplicate

      final pendingId = dashboardController.pendingNewsId;

      if (pendingId != null && pendingId.isNotEmpty) {
        _handledNavigation = true;

        dashboardController.clearPendingNews();

        Get.to(() => NewsDetailScreen(
          newsId: pendingId,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: RefreshIndicator (
          onRefresh: () =>
              controller.fetchNews(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16, top: 16, bottom: 10),
                child: Text(
                  "News",
                  style: TextStyle(fontSize: 24),
                ),
              ),

              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.newsList.isEmpty) {
                    return const Center(child: Text("No news available"));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: controller.newsList.length,
                    itemBuilder: (context, index) {
                      final news = controller.newsList[index];

                      print("NEWS : ${news.newsID}");
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => NewsDetailScreen(news: news));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// IMAGE
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    news.thumbViewImageURL ?? '',
                                   // height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                    const SizedBox(
                                      height: 120,
                                      child: Center(child: Icon(Icons.image)),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 12),

                                /// TITLE
                                Text(
                                  news.storyPreview ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                /// SOURCE + DATE
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${news.source ?? ''} • ${news.publishedOn ?? ''}",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff505050),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),

                                    Obx(() {
                                      final id = news.newsID?.toString() ?? '';
                                      final isFav = controller.isFavorite(id);

                                      return IconButton(
                                        onPressed: () {
                                          controller.toggleFavorite(id);
                                        },
                                        icon: Icon(
                                          isFav ? Icons.favorite : Icons.favorite_border,
                                          color: isFav ? Colors.red : Colors.grey,
                                        ),
                                      );
                                    })
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
