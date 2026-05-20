import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kerala_association/core/model/home_page_response.dart';
import 'package:kerala_association/core/res/colors.dart';
import '../../../helper/utils/format_utils.dart';
import '../management/management_screeen.dart';
import '../web_view_screen.dart';
import 'home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          return RefreshIndicator (
            onRefresh: () async => controller.fetchHomePageData(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 12,
                  bottom: 50,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BannerImage(controller: controller),
                    SizedBox(height: 20),
                    rateCard(),
                    memberList(),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Container rateCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(color: AppColor.green),
        borderRadius: BorderRadius.circular(12),
      ),
      width: double.infinity,
      child: ClipRRect (
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Positioned(right: 0, child: SvgPicture.asset("assets/flower1.svg")),
            Positioned(
              left: 0,
              bottom: 0,
              child: SvgPicture.asset("assets/flower2.svg"),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(
                          () => Text(
                            controller.rateTitle.value,
                            style: TextStyle(
                              fontSize: 24,
                              color: AppColor.green,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(width: 6),
                        Text("( Gst Not Included )"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/calender.svg",
                          color: AppColor.black,
                        ),
                        SizedBox(width: 6),
                        Obx(
                          () => Text(
                            controller.rateDate.value,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: AppColor.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          child: VerticalDivider(color: AppColor.textPrimary),
                        ),
                        SvgPicture.asset(
                          "assets/clock.svg",
                          color: AppColor.black,
                        ),
                        SizedBox(width: 6),
                        Obx(() => Text(controller.rateTime.value)),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.groupedRates.length,
                    itemBuilder: (context, index) {
                      final group = controller.groupedRates[index];
                      return GroupedRateCard(
                        group: group,
                        controller: controller,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget memberList() {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 600;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24),
        Text(
          "Executive Board",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: AppColor.green,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Meet the visionaries who built this community from the ground up",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 20),
        GridView.builder(
          itemCount: controller.leaders.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isWide ? 3 : 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            final leader = controller.leaders[index];
            return LeaderCard(
              imagePath: leader.photoURL ?? '',
              name: leader.name ?? '',
              role: leader.designation ?? '',
            );
          },
        ),
      ],
    );
  }
}

// class RateItemCard extends StatelessWidget {
//   final Rates rate;
//   HomeController controller;
//
//   RateItemCard({super.key, required this.rate, required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = controller.getMetalTheme(rate);
//     return IntrinsicWidth(
//       child: Stack(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(14),
//               gradient: LinearGradient(
//                 colors: theme.gradient,
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               boxShadow: [
//                 BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
//               ],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       rate.label ?? '',
//                       style: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     Container(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 10,
//                         vertical: 3,
//                       ),
//                       decoration: BoxDecoration(
//                         color: AppColor.textPrimary,
//                         borderRadius: BorderRadius.circular(100),
//                       ),
//                       child: Text(
//                         rate.unit ?? '',
//                         style: TextStyle(
//                           color: AppColor.white,
//                           fontWeight: FontWeight.w500,
//                           fontSize: 15,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 6),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: FittedBox(
//                         fit: BoxFit.scaleDown,
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           "₹ ${rate.ratePerUnit}",
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     buildTrend(rate),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildTrend(Rates rate) {
//     switch (rate.flag) {
//       case 1: // UP
//         return Row(
//           children: [
//             SvgPicture.asset("assets/priceHigh.svg", height: 16),
//             const SizedBox(width: 4),
//             Text(
//               "₹ ${rate.rateTrend}",
//               style: const TextStyle(
//                 fontSize: 16,
//                 // color: Colors.green,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         );
//
//       case 2: // DOWN
//         return Row(
//           children: [
//             SvgPicture.asset("assets/priceLOW.svg", height: 16),
//             const SizedBox(width: 4),
//             Text(
//               "₹ ${rate.rateTrend}",
//               style: const TextStyle(
//                 fontSize: 16,
//                 // color: Colors.red,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         );
//
//       case 0: // NO CHANGE
//       default:
//         return Row(
//           children: [
//             SvgPicture.asset("assets/neutral.svg", height: 16),
//             SizedBox(width: 4),
//             Text("0", style: TextStyle(fontSize: 14, color: Colors.grey)),
//           ],
//         );
//     }
//   }
// }

class GroupedRateCard extends StatelessWidget {
  final GroupedRate group;
  final HomeController controller;

  const GroupedRateCard({
    super.key,
    required this.group,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = controller.getMetalTheme(group.items.first);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.only(top: 6,bottom: 6,left: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(colors: theme.gradient),
      ),
      child:
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          /// LEFT: Title (fixed width for alignment)
          SizedBox(
            width: 55,
            child: Text(
              group.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          /// CENTER: Rates (takes remaining space)
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(group.items.length, (index) {
                final rate = group.items[index];

                return Column(
                  children: [
                    Row(
                      children: [
                        /// UNIT BADGE
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.green,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            rate.unit!.toLowerCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        /// PRICE (aligned)
                        Expanded(
                          child: Text(
                            FormatUtils.formatCurrency(rate.ratePerUnit),
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            // style: const TextStyle(
                            //   fontFamily: 'Inter',
                            //   fontSize: 20,
                            // ),
                          ),
                        ),
                      ],
                    ),

                    if (index != group.items.length - 1)
                      Divider(
                        color: Colors.grey.shade400,
                        thickness: 0.5,
                        height: 6,
                      ),
                  ],
                );
              }),
            ),
          ),

          SizedBox(width: 10,),
          /// RIGHT: Trend (fixed width)
          SizedBox(
            width: 90,
            child: Align(
              alignment: Alignment.centerRight,
              child: buildTrend(group.items.first),
            ),
          ),
        ],
      )

      // Row(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: [
      //     /// LEFT: 24kt
      //     SizedBox(width: 25,),
      //     Text(
      //       group.title,
      //       style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      //     ),
      //
      //     const SizedBox(width: 18),
      //
      //     Expanded(
      //       child: Column(
      //         children: List.generate(group.items.length, (index) {
      //           final rate = group.items[index];
      //           return Column(
      //             children: [
      //               Row(
      //                 children: [
      //                   Container(
      //                     padding: const EdgeInsets.symmetric(
      //                       horizontal: 10,
      //                       vertical: 4,
      //                     ),
      //                     decoration: BoxDecoration(
      //                       color: AppColor.green,
      //                       borderRadius: BorderRadius.circular(50),
      //                     ),
      //                     child: Text(
      //                       rate.unit!.toLowerCase(),
      //                       style: const TextStyle(color: Colors.white,fontSize: 14),
      //                     ),
      //                   ),
      //                   const SizedBox(width: 10),
      //                   Expanded(
      //                     child: Text(
      //                       "₹ ${rate.ratePerUnit}",
      //                       style: const TextStyle(
      //                         fontSize: 20,
      //                         fontWeight: FontWeight.w600,
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //
      //               if (index != group.items.length - 1)
      //                 Divider(
      //                   color: Colors.grey.shade400,
      //                   height: 6, thickness: 0.5,
      //                 ),
      //             ],
      //           );
      //         }),
      //       ),
      //     ),
      //
      //     const SizedBox(width: 18),
      //     buildTrend(group.items.first),
      //     const SizedBox(width: 18),
      //   ],
      // ),
    );
  }

  Widget buildTrend(Rates rate) {
    if (rate.flag == 1) {
      return Row(
        children: [
          SvgPicture.asset("assets/priceHigh.svg", height: 22),
          const SizedBox(width: 4),
          Text("₹ ${rate.rateTrend}",style: TextStyle(fontSize: 22)),
        ],
      );
    } else if (rate.flag == 2) {
      return Row(
        children: [
          SvgPicture.asset("assets/priceLOW.svg", height: 22),
          const SizedBox(width: 4),
          Text("₹ ${rate.rateTrend}",style: TextStyle(fontSize: 22),),
        ],
      );
    } else {
      return const Text("-");
    }
  }
}

class BannerImage extends StatelessWidget {
  const BannerImage({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CarouselSlider(
          items:
              controller.sliders.map((item) {
                return GestureDetector(
                  onTap: () {
                    final url = item.sliderStoryURL;

                    if (url == null ||
                        url.isEmpty ||
                        url == "#" ||
                        !url.startsWith("http")) {
                      return; // 🚫 do nothing
                    }
                    Get.to(() => WebViewScreen(url: url));
                  },
                  child: Image.network(
                    item.sliderImageURL ?? "",
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                );
              }).toList(),
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 3.8 / 2.8,
            viewportFraction: 1.0,
            clipBehavior: Clip.hardEdge,
            onPageChanged: (index, reason) {
              //    controller.index.value = index;
            },
          ),
        ),
      );
    });
  }
}
