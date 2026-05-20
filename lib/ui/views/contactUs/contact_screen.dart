import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kerala_association/core/res/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Text("Contact Us", style: TextStyle(color: AppColor.black)),
      ),
      body: SafeArea (
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    SvgPicture.asset("assets/phone.svg"),
                    SizedBox(height: 6),
                    Text("How can we help you?", style: TextStyle(fontSize: 24)),
                    SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        "We're here to assist you with any questions or concerns",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColor.textDisable,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () async {
                              const phoneNumber = "tel:9935043504"; // no spaces
                              if (await canLaunchUrl(Uri.parse(phoneNumber))) {
                                await launchUrl(Uri.parse(phoneNumber));
                              } else {
                                throw "Could not launch $phoneNumber";
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                left: 10,
                                top: 10,
                                bottom: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColor.white,
                                border: Border.all(color: Color(0xffA6681B)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Phone Support",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppColor.green,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.local_phone,
                                        color: AppColor.green,
                                      ),
                                      SizedBox(width: 4),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Call us for assistance",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.subTitle,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            "9935 043 504",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.subTitle,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12),
                              ),
                              child: SvgPicture.asset("assets/contactFlower.svg"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () async {

                              final Uri emailUri = Uri(
                                scheme: 'mailto',
                                path: 'mktg@uemail.in',
                              );


                              if (!await launchUrl(
                                emailUri,
                                mode: LaunchMode.externalApplication, // important for Android/iOS
                              )) {
                                throw Exception('Could not launch $emailUri');
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                left: 10,
                                top: 10,
                                bottom: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColor.white,
                                border: Border.all(color: Color(0xffA6681B)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Email Support",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppColor.green,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.email, color: AppColor.green),
                                      SizedBox(width: 4),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Send us a detailed message",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.subTitle,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            "mktg@uemail.in",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.subTitle,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12),
                              ),
                              child: SvgPicture.asset("assets/contactFlower.svg"),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: 10,
                              top: 10,
                              bottom: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColor.white,
                              border: Border.all(color: Color(0xffA6681B)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Ways to Reach Us",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColor.green,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: AppColor.green,
                                    ),
                                    SizedBox(width: 4),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "KGSMA",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.subTitle,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            "29/993, Archana Building Koduvally P.o., Calicut, Kerala , Pin- 673572",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.subTitle,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12),
                              ),
                              child: SvgPicture.asset("assets/contactFlower.svg"),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                              left: 10,
                              top: 10,
                              bottom: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColor.white,
                              border: Border.all(color: Color(0xffA6681B)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Business Hours",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColor.green,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  "Monday - Friday   9:00 AM - 6:00 PM ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.subTitle,
                                  ),
                                ),

                                SizedBox(height: 6),
                                Text(
                                  "Saturday   10:00 AM - 4:00 PM  ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.subTitle,
                                  ),
                                ),

                                SizedBox(height: 6),
                                Text(
                                  "Sunday  Closed ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.subTitle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12),
                              ),
                              child: SvgPicture.asset("assets/contactFlower.svg"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/crown-circle.svg"),
                  SizedBox(width: 4),
                  Text(
                    "Building the future together since 2019",
                    style: TextStyle(fontSize: 14, color: AppColor.textDisable),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
