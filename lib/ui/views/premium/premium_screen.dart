
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kerala_association/common_widget/common_button.dart';
import 'package:kerala_association/core/res/colors.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Premium Features",
          style: TextStyle(color: AppColor.black),
        ),
      ),
      body: SafeArea (
        child: SingleChildScrollView (
          child: Column(
            children: [
              SizedBox(height: 30),
              SvgPicture.asset("assets/premium.svg",),
              SizedBox(height: 10),
              Text("Unlock Premium", style: TextStyle(fontSize: 24)),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 55),
                child: Text(
                  "Get access to all premium features and take your experience to the next level",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColor.textDisable,
                  ),
                ),
              ),
              SizedBox(height: 18),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    border: Border.all(color: AppColor.primary),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Yearly Subscription",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Save 40% compared to monthly",
                        style: TextStyle(fontSize: 16, color: AppColor.textDisable),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 6,horizontal: 10),
                        decoration: BoxDecoration(color: AppColor.white,border: Border.all(color: AppColor.green), borderRadius: BorderRadius.circular(6)),
                        child: Text(
                          "₹1,500  /year (₹125 per month)",
                          style: TextStyle(
                            color: AppColor.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("What's included:",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                    SizedBox(height: 16,),
                    Row(
                      children: [
                        SvgPicture.asset("assets/analytics.svg",height: 55,),
                        SizedBox(width: 10,),
                        Expanded (
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Advanced Analytics",style: TextStyle(fontSize: 18),),
                              Text("Detailed insights and performance metrics",style: TextStyle(fontSize: 16,color: AppColor.textDisable),),
                            ],
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 16,),
                    Row(
                      children: [
                        SvgPicture.asset("assets/priority.svg",height: 55,),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Priority Support",style: TextStyle(fontSize: 18),),
                            Text("24/7 dedicatee support team",style: TextStyle(fontSize: 16,color: AppColor.textDisable),),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 16,),
                    Row(
                      children: [
                        SvgPicture.asset("assets/lock.svg",height: 55,),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Unlimited Access",style: TextStyle(fontSize: 18),),
                            Text("No limits on usage or features",style: TextStyle(fontSize: 16,color: AppColor.textDisable),),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 16,),
                    Row(
                      children: [
                        SvgPicture.asset("assets/download.svg",height: 55,),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Export & Backup",style: TextStyle(fontSize: 18),),
                            Text("Download your data anytime",style: TextStyle(fontSize: 16,color: AppColor.textDisable),),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 16,),
                    Row(
                      children: [
                        SvgPicture.asset("assets/custom.svg",height: 55,),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Custom Themes",style: TextStyle(fontSize: 18),),
                            Text("Personalize your expenence",style: TextStyle(fontSize: 16,color: AppColor.textDisable),),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    CommonButton(
                      text: "Start Free Trial",
                      onPressed: () {},
                      borderRadius: BorderRadius.circular(40),
                      suffixIcon: SvgPicture.asset(
                        "assets/arrow_outward.svg",
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
