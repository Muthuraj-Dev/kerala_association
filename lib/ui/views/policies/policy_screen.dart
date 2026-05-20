
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kerala_association/core/res/colors.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({super.key});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Privacy Policy", style: TextStyle(color: AppColor.black)),
      ),
      body: SafeArea (
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              Expanded (
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Image.asset("assets/app_logo.png", height: 54),
                            Text(
                              "APBGSDMA",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                                color: AppColor.secondary,
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
                                child: Text("Since 2018"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      CardContainer(
                          // icon: 'assets/people.svg',
                          title: "Data and Privacy",
                          description:
                          "At KGSMA, we prioritize your privacy and are committed to safeguarding your personal information. This Privacy Policy outlines how we collect, use, and protect your data when you interact with our website."
                      ),
                      SizedBox(height: 6),
                      CardContainer(
                          title: "Data We Gather",
                          description:
                          "When you access or update your account information, our secure server technology safeguards your data.We follow strict security protocols aligned with industry best practices to ensure your personal details remain protected."
                      ),
                      SizedBox(height: 6),
                      CardContainer(
                          title: "Protected Transactions",
                          description:
                          "Whenever you update or access your account information, we use secure server technology to protect your data. Ourstringent security protocols adhere to industry best practices, ensuring that your personal details remain safe."
                      ),
                      SizedBox(height: 6),
                      CardContainer(
                          title: "Data Safeguards",
                          description:
                          "We apply strict protocols to shield your information from unauthorized access. Our platform uses encryption and advanced security technologies to ensure the integrity and confidentiality of your data."
                      ),

                      SizedBox(height: 6),
                      CardContainer(
                          title: "Safeguarding Your Privacy",
                          description:
                          "At KGSMA, we are committed to upholding the highest standards of data protection. We collect your information solely to improve your experience and never share, sell, or misuse your personal data. By using our application, you agree to the practices described in this Privacy Policy. We may update this policy from time to time to align with evolving security measures and regulatory requirements."
                      ),


                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16,top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/crown-circle.svg"),
                    SizedBox(width: 4),
                    Text(
                      "Building the future together since 2019",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColor.textDisable,
                      ),
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
