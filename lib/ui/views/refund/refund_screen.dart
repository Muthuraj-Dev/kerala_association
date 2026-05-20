import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/res/colors.dart';

class RefundScreen extends StatefulWidget {
  const RefundScreen({super.key});

  @override
  State<RefundScreen> createState() => _RefundScreenState();
}

class _RefundScreenState extends State<RefundScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Refund and Cancellation Policy",
          style: TextStyle(color: AppColor.black),
        ),
      ),
      body: SafeArea (
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 150,
                              ),
                              child: Image.asset("assets/app_logo.png"),
                            ),
                            Text(
                              "KGSMA",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: AppColor.textPrimary,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColor.secondary,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 3,
                                ),
                                child: Text(
                                  "Updated: 26 Aug 2025",
                                  style: TextStyle(color: AppColor.secondary),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      CardContainer(
                        //  icon: 'assets/people.svg',
                        title: "Refunds & Cancellations",
                        description:
                            "At KGSMA, we are committed to ensuring member satisfaction with our services. However, we recognize that certain circumstances may require refunds or cancellations. Such requests will be reviewed in accordance with our refund and cancellation policy.",
                      ),
                      SizedBox(height: 6),
                      CardContainer(
                        title: "Subscription & Event Registration Policy",
                        description:
                            "Membership fees and event registration charges are strictly non-refundable. However, in the event of a cancellation initiated by KGSMA, all registered participants will be entitled to a full refund.",
                      ),
                      SizedBox(height: 6),
                      CardContainer(
                        title: "Service & Product Transactions Policy",
                        description:
                            "If you believe you have been charged incorrectly, please contact our support team within 7 days of the transaction for resolution. Refunds, if applicable, will be processed within 30 business days through the original method of payment.",
                      ),

                      SizedBox(height: 6),
                      CardContainer(
                        // icon: 'assets/people.svg',
                        title: "Exceptional Conditions",
                        description:
                            "Refunds may be considered on a case-by-case basis under exceptional circumstances, subject to the sole discretion of KGSMA’s management.",
                      ),

                      SizedBox(height: 6),
                      CardContainer(
                        // icon: 'assets/people.svg',
                        title:
                            "For any inquiries regarding refunds or cancellations, please reach out to our support team",
                        description:
                            "All members must comply with applicable laws, regulations, and guidelines governing the jewellery trade. KGSMA expects its members to uphold lawful business practices at all times, and any violation may result in disciplinary action, including suspension or termination of membership.",
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/crown-circle.svg"),
                    SizedBox(width: 4),
                    Text(
                      "Last updated on 26th August 2025",
                      style: TextStyle(fontSize: 14, color: AppColor.textDisable),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class CardContainer extends StatelessWidget {
//   String? icon;
//   String title;
//   String description;
//
//   CardContainer({
//     super.key,
//     this.icon,
//     required this.title,
//     required this.description,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(12),
//           topLeft: Radius.circular(12),
//         ),
//         color: AppColor.white,
//         border: Border.all(color: Color(0xffA6681B)),
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               icon?.isNotEmpty == true ?
//               SvgPicture.asset(icon!) : SizedBox.shrink() ,
//               SizedBox(width: icon?.isNotEmpty == true ? 6 : 0),
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.subTitle,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 6),
//           Text(
//             description,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//               height: 1.5,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class CardContainer extends StatelessWidget {
  final String? icon;
  final String title;
  final String? description;
  final Widget? content; // ✅ replaces description String

  const CardContainer({
    super.key,
    this.icon,
    required this.title,
    this.description,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
        color: AppColor.white,
        border: Border.all(color: const Color(0xffA6681B)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // ✅ better alignment
        children: [
          Row(
            children: [
              if (icon?.isNotEmpty == true) ...[
                SvgPicture.asset(icon!),
                const SizedBox(width: 6),
              ],
              Expanded (
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColor.subTitle,
                  ),
                ),
              ),

            ],
          ),
          SizedBox(height: 6),
          Text(
            description!,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 6),
          if (content != null) ...[
            const SizedBox(height: 6),
            content!, // ✅ only render when not null
          ],
        ],
      ),
    );
  }
}
