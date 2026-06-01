import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kerala_association/common_widget/common_button.dart';
import 'package:kerala_association/core/res/colors.dart';
import 'package:kerala_association/ui/views/aboutUs/about_screen.dart';
import 'package:kerala_association/ui/views/phone/phone_screen.dart';
import 'package:kerala_association/ui/views/policies/policy_screen.dart';
import 'package:kerala_association/ui/views/profile/profile_controller.dart';
import 'package:kerala_association/ui/views/refund/refund_screen.dart';
import 'package:kerala_association/ui/views/terms/terms_screeen.dart';
import '../contactUs/contact_screen.dart';
import '../create_account/create_account_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const _Header(),
            const SizedBox(height: 26),
            const _InfoTitle(),
            _ProfileMenu(controller),
          ],
        ),
      ),
    );
  }
}

void _navigateToLogin() {
  Get.to(() => const PhoneScreen());
  //  Get.to(() => CreateAccountScreen());
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "My Profile",
          style: TextStyle(
            color: AppColor.green,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 14),

        Obx(() {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: AppColor.secondary),
            ),
            padding: const EdgeInsets.all(14),
            child:
                controller.hasPan.value
                    ? _LoggedInView(controller: controller)
                    : _GuestView(),
          );
        }),
      ],
    );
  }
}

class _LoggedInView extends StatelessWidget {
  final ProfileController controller;

  const _LoggedInView({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.person_sharp),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi, ${controller.memberName.value}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              controller.memberId.isNotEmpty ?
              Text(
                "Member ID: ${controller.memberId.value}",
                style: const TextStyle(fontSize: 14),
              ) : SizedBox.shrink(),
              const SizedBox(height: 2),
              Row(
                children: [
                  Text(
                    controller.mobileNumber.value,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        () => CreateAccountScreen(),
                        arguments: {
                          "isEdit": true,
                          "data": controller.userData.value,
                        },
                      );
                    },
                    child: const Text(
                      "Update",
                      style: TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GuestView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              "assets/profile_inactive.png",
              color: AppColor.secondary,
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi, Welcome",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Login or Signup to access new features and connections",
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        CommonButton(
          text: "Login / Sign Up",
          fillColor: AppColor.secondary,
          borderRadius: BorderRadius.circular(60),
          onPressed: _navigateToLogin,
        ),
      ],
    );
  }
}

class _InfoTitle extends StatelessWidget {
  const _InfoTitle();

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Your Info Center:",
      style: TextStyle(
        color: AppColor.green,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _ProfileMenu extends StatelessWidget {
  ProfileController controller;

  _ProfileMenu(this.controller);

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Column(
        children: [
          // _ProfileTile(
          //   title: 'Premium',
          //   icon: 'assets/crown.svg',
          //   onTap: () => Get.to(() => const PremiumScreen()),
          // ),
          _ProfileTile(
            title: 'About Us',
            icon: 'assets/info.svg',
            onTap: () => Get.to(() => const AboutScreen()),
          ),
          _ProfileTile(
            title: 'Terms & Conditions',
            icon: 'assets/terms.svg',
            onTap: () => Get.to(() => const TermsScreen()),
          ),
          _ProfileTile(
            title: 'Privacy Policy',
            icon: 'assets/privacy_policy.svg',
            onTap: () => Get.to(() => const PolicyScreen()),
          ),
          _ProfileTile(
            title: 'Refund and Cancellation Policy',
            icon: 'assets/refund.svg',
            onTap: () => Get.to(() => const RefundScreen()),
          ),
          _ProfileTile(
            title: 'Contact Us',
            icon: 'assets/contact.svg',
            onTap: () => Get.to(() => const ContactScreen()),
          ),
          controller.hasPan.value
              ? _ProfileTile(
            title: 'Logout',
            icon: 'assets/logout.svg',
            onTap: controller.logout,
            showDivider: true,
          )
              : SizedBox.shrink(),

          controller.hasPan.value
              ? _ProfileTile(
            title: 'Account Deletion',
            icon: 'assets/delete.svg',
            onTap: controller.deleteAccount,
            showDivider: false,
          )
              : SizedBox.shrink(),
        ],
      );
    });
  }
}

class _ProfileTile extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;
  final bool showDivider;

  const _ProfileTile({
    required this.title,
    required this.icon,
    required this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                SvgPicture.asset(icon, color: AppColor.green),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios, size: 18),
              ],
            ),
          ),
        ),
        if (showDivider) const Divider(),
      ],
    );
  }
}

// class SemiCircleProgress extends StatelessWidget {
//   final double percentage;
//
//   const SemiCircleProgress({super.key, required this.percentage});
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         SizedBox(
//           width: 199,
//           height: 100,
//           child: CustomPaint(
//             painter: SemiCircleProgressPainter(
//               percentage: percentage,
//               progressColor: const Color(0xFF244E2C), // dark green
//               backgroundColor: const Color(0xFFE6E6E6),
//               strokeWidth: 14,
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: 10,
//           left: 70,
//           child: Text(
//             "${(percentage * 100).toInt()}%",
//             style: const TextStyle(
//               fontSize: 32,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFFB57A2B), // gold
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class SemiCircleProgressPainter extends CustomPainter {
//   final double percentage;
//   final Color progressColor;
//   final Color backgroundColor;
//   final double strokeWidth;
//
//   SemiCircleProgressPainter({
//     required this.percentage,
//     required this.progressColor,
//     required this.backgroundColor,
//     this.strokeWidth = 14,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height);
//     final radius = size.width / 2;
//
//     final backgroundPaint =
//         Paint()
//           ..color = backgroundColor
//           ..strokeWidth = strokeWidth
//           ..style = PaintingStyle.stroke
//           ..strokeCap = StrokeCap.round;
//
//     final progressPaint =
//         Paint()
//           ..color = progressColor
//           ..strokeWidth = strokeWidth
//           ..style = PaintingStyle.stroke
//           ..strokeCap = StrokeCap.round;
//
//     // Background arc
//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius),
//       pi, // start angle
//       pi, // full semi circle
//       false,
//       backgroundPaint,
//     );
//
//     // Progress arc
//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius),
//       pi,
//       pi * percentage,
//       false,
//       progressPaint,
//     );
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }

// class _Header extends StatelessWidget {
//   const _Header();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "My Profile",
//           style: TextStyle(
//             color: AppColor.green,
//             fontSize: 24,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         const SizedBox(height: 14),
//         Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(28),
//             border: Border.all(color: AppColor.secondary),
//           ),
//           padding: const EdgeInsets.all(14),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Image.asset(
//                     "assets/profile_inactive.png",
//                     color: AppColor.secondary,
//                   ),
//                   const SizedBox(width: 10),
//                   const Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Hi, Sir",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           "Login or Signup to access new features and connections",
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               CommonButton(
//                 text: "Login / Sign Up",
//                 fillColor: AppColor.secondary,
//                 borderRadius: BorderRadius.all(Radius.circular(60)),
//                 onPressed: _navigateToLogin,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//
//   }
//

// }

// return Column(
//   children: [
//     Stack(
//       children: [
//         Container(
//           height: 150,
//           width: 150,
//           padding: const EdgeInsets.all(6),
//           // border width
//           decoration: BoxDecoration(
//             gradient: const LinearGradient(
//               colors: [
//                 Color(0xFF2EAD65),
//                 Color(0xFF175831), // light green
//               ],
//               begin: Alignment.topRight,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(100),
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//               color: AppColor.divider,
//               borderRadius: BorderRadius.circular(92), // 100 - 8
//             ),
//           ),
//         ),
//         Positioned(
//           right: 0,
//           top: 10,
//           child: Container(
//             height: 36,
//             width: 36,
//             decoration: BoxDecoration(
//               color: AppColor.primary,
//               borderRadius: BorderRadius.circular(100),
//             ),
//             child: Icon(Icons.edit, color: Colors.white),
//           ),
//         ),
//       ],
//     ),
//     Text("Viraj Anand", style: TextStyle(fontSize: 24)),
//     Text("+91 987 654 3210", style: TextStyle(fontSize: 18)),
//     Text("virajanand.official@gmail.com", style: TextStyle(fontSize: 18)),
//     SizedBox(height: 18),
//     CommonButton(
//       text: "Get Premium",
//       onPressed: () {},
//       isFilled: false,
//       isOutlined: true,
//       outlineColor: AppColor.secondary,
//       borderRadius: BorderRadius.circular(100),
//       textColor: AppColor.secondary,
//       isTransparent: true,
//     ),
//     SizedBox(height: 12),
//
//     Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: const Color(0xFFF9FBF7),
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Column(
//         children: [
//           SemiCircleProgress(percentage: 0.6),
//
//           const SizedBox(height: 16),
//
//           Text(
//             "You're almost there",
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.w600,
//               color: AppColor.green,
//             ),
//           ),
//
//           const SizedBox(height: 8),
//
//           const Text(
//             "Just a few more steps to complete the verification process, and you're good to go.",
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 16),
//           ),
//
//           const SizedBox(height: 20),
//
//           CommonButton(
//             text: "Continue Verification",
//             onPressed: () {},
//             fillColor: AppColor.secondary,
//             borderRadius: BorderRadius.circular(26),
//           ),
//         ],
//       ),
//     ),
//   ],
// );
