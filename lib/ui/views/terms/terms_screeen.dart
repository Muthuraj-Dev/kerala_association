
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kerala_association/core/res/colors.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Terms & Conditions", style: TextStyle(color: AppColor.black)),
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
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 150),
                              child: Image.asset("assets/app_logo.png",),
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
                                child: Text("Updated: 26 Aug 2025",style: TextStyle(color: AppColor.secondary),),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      CardContainer(
                      //  icon: 'assets/people.svg',
                        title: "Membership Criteria",
                        description:
                          "Membership is open to individuals and businesses engaged in the jewellery trade. All members are required to follow the rules and regulations established by KGSMA. Membership may be revoked if a member is found to be involved in unethical business practices."
                      ),
                      SizedBox(height: 6),
                      CardContainer(
                          title: "Code of Ethics",
                          description:
                          "embers are expected to conduct their business with integrity, transparency, and professionalism. Any disputes between members should be resolved amicably through KGSMA’s mediation process."
                      ),
                      SizedBox(height: 6),
                      CardContainer(
                          title: "Utilization of Association Services",
                          description:
                          "Members must not misuse the association’s name, logo, or reputation for personal gain. Participation in association events is subject to eligibility and availability."
                      ),

                      SizedBox(height: 6),
                      CardContainer(
                          icon: 'assets/people.svg',
                          title: "Intellectual Property Guidelines",
                          description:
                          "All materials, logos, and content provided by KGSMA remain the exclusive property of the association. Any unauthorized use of KGSMA’s intellectual property is strictly prohibited."
                      ),

                      SizedBox(height: 6),
                      CardContainer(
                          icon: 'assets/people.svg',
                          title: "Legal & Regulatory Frameworks",
                          description:
                          "All members must comply with applicable laws, regulations, and guidelines governing the jewellery trade. KGSMA expects its members to uphold lawful business practices at all times, and any violation may result in disciplinary action, including suspension or termination of membership."
                      ),

                      SizedBox(height: 6),
                      CardContainer(
                          icon: 'assets/people.svg',
                          title: "Limitation of Liability",
                          description:
                          "KGSMA shall not be held responsible for any losses, damages, or disputes arising from transactions between members or with third parties. Members are advised to seek independent legal or financial advice before entering into any agreements."
                      ),

                      SizedBox(height: 6),
                      CardContainer(
                          title: "Modification of Terms",
                          description:
                          "KGSMA reserves the right to amend or update these Terms and Conditions as deemed necessary. Members will be informed in advance of any significant changes."
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
                      "Last updated on 26th August 2025",
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
  String? icon;
  String title;
  String description;

  CardContainer({
    super.key,
    this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
        color: AppColor.white,
        border: Border.all(color: Color(0xffA6681B)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              icon?.isNotEmpty == true ?
              SvgPicture.asset(icon!) : SizedBox.shrink() ,
              SizedBox(width: icon?.isNotEmpty == true ? 6 : 0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColor.subTitle,
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
