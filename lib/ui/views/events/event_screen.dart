import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kerala_association/common_widget/common_button.dart';
import 'package:kerala_association/core/res/colors.dart';
import 'package:kerala_association/ui/views/events/event_controller.dart';

class EventScreen extends StatelessWidget {
  EventScreen({super.key});

  final EventController controller = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 16, bottom: 10),
              child: Text("Pre-Registration", style: TextStyle(fontSize: 24)),
            ),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.events.isEmpty) {
                  return const Center(child: Text("No events found"));
                }

                return RefreshIndicator(
                  onRefresh: controller.fetchEvents,
                  child:
                      controller.events.isEmpty
                          ? ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: const [
                              SizedBox(height: 200),
                              Center(child: Text("No events found")),
                            ],
                          )
                          : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: controller.events.length,
                            itemBuilder: (_, index) {
                              final event = controller.events[index];

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /// EVENT LOGO
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          event.eventLogo?.trim() ?? '',
                                          //   height: 120,
                                          width: double.infinity,
                                          fit: BoxFit.contain,
                                          loadingBuilder: (
                                            context,
                                            child,
                                            progress,
                                          ) {
                                            if (progress == null) return child;
                                            return const SizedBox(
                                              height: 120,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                    ),
                                              ),
                                            );
                                          },
                                          errorBuilder:
                                              (_, __, ___) => const SizedBox(
                                                height: 120,
                                                child: Icon(
                                                  Icons.image,
                                                  size: 40,
                                                ),
                                              ),
                                        ),
                                      ),

                                      const SizedBox(height: 12),

                                      /// EVENT NAME
                                      Text(
                                        event.eventFullName ?? '',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),

                                      const SizedBox(height: 8),

                                      /// DATE
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/calender.svg",
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            event.eventDate ?? '',
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 8),

                                      /// LOCATION
                                      Row(
                                        children: [
                                          Icon(Icons.location_on_outlined),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                             "${event.venue}, ${event.city}" ?? '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 14),

                                      /// ACTION BUTTONS
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CommonButton(
                                              text: "Book Pass for Pre-Register",
                                              borderRadius: BorderRadius.circular(42),
                                              //            height: 40,
                                              onPressed: () {
                                                controller.launchUrlSafe(
                                                  event.visitorRegistrationURL,
                                                );
                                              },
                                              suffixIcon: SvgPicture.asset(
                                                "assets/arrow_outward.svg",
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          // const SizedBox(width: 16),
                                          // Expanded(
                                          //   child: CommonButton(
                                          //     text: "Stall enquiry",
                                          //     //     height: 40,
                                          //     borderRadius: BorderRadius.circular(42),
                                          //     isOutlined: true,
                                          //     isFilled: false,
                                          //     isTransparent: true,
                                          //     onPressed: () {
                                          //       controller.launchUrlSafe(
                                          //         event.stallEnquiryURL,
                                          //       );
                                          //     },
                                          //     suffixIcon: SvgPicture.asset(
                                          //       "assets/arrow_outward.svg",
                                          //       color: AppColor.green,
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
