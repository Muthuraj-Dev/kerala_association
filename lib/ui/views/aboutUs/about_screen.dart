
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kerala_association/core/res/colors.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("About Us", style: TextStyle(color: AppColor.black)),
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
                        icon: 'assets/people.svg',
                        title: "About KGSMA",
                        description: "The Kerala Gold & Silver Merchants Association (KGSMA) is committed to promoting the growth and advancement of the gems and jewellery industry.",
                      ),
                      SizedBox(height: 6),
                      CardContainer(
                        icon: 'assets/people.svg',
                        title: "Our Core Mission",
                        description:
                          "We are dedicated to promoting and supporting the establishment of new derivative and related markets, while fostering stronger communication and collaboration among our valued members. Through knowledge-sharing and networking, we aim to build lasting industry relationships and enable the exchange of valuable insights and experiences."
                      ),
                      SizedBox(height: 6),
                      CardContainer(
                        icon: 'assets/people.svg',
                        title: "Leadership in Action",
                        description:
                          "The association is currently led by K. Surendran, whose visionary guidance is strengthened by the dedicated contributions of General Secretary Adv. S. Abdul Nazar, Treasurer C. V. Krishnadas, Working President P. K. Ayamu Haji, Working General Secretary B. Premanand, Working General Secretary M. Vineeth, and a dynamic executive committee of both experienced and energetic members. Together, their collective expertise ensures the smooth functioning of the association, driving its initiatives with integrity and excellence."
                      ),

                      SizedBox(height: 6),
                      CardContainer(
                        icon: 'assets/people.svg',
                        title: "Industry Evaluation & Honors Panel",
                        description:
                          "The KGSMA Industry Evaluation & Honors Panel plays a vital role in industry regulation and assessment. To uphold industry standards, a specialized panel has been created to appraise gems and jewelry. Our credibility as a trusted authority is reinforced by the panel's recognition from key government bodies, including the Department of Customs, Central Excise, Sales and Income Tax Departments, and the Judiciary."
                      ),

                      SizedBox(height: 6),
                      CardContainer(
                        icon: 'assets/people.svg',
                        title: "A Trusted Trade Body",
                        description:
                          "Built on a legacy of discipline, professionalism, and ethical business practices, KGSMA has earned government recognition as a respected trade body, on par with the Chambers of Commerce. Guided by the exemplary leadership of Sri. K. Surendran, the association plays a pivotal role in shaping policies and establishing a strong framework for jewellers and traders. With a focus on growth, innovation, and collaboration, KGSMA continues to strengthen the gems and jewellery industry while fostering a thriving business ecosystem."
                      ),

                      SizedBox(height: 6),
                      CardContainer(
                        icon: 'assets/people.svg',
                        title: "Our Aspirations",
                        description:
                          "The Kerala Gold & Silver Merchants Association – Calicut is dedicated to delivering effective services and timely business-related communication to its members, in line with the association’s charter and the evolving needs of the industry. KGSMA is committed to fostering professional excellence by motivating and training its employees to provide value-added services, while continuously enhancing its Quality Management System. Through this commitment, KGSMA strives to meet and exceed the stated and unstated needs and expectations of its members and other stakeholders."
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
  String icon;
  String title;
  String description;

  CardContainer({
    super.key,
    required this.icon,
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
              SvgPicture.asset(icon),
              SizedBox(width: 6),
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
