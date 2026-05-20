
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kerala_association/core/res/colors.dart';

class FinancialScreen extends StatefulWidget {
  const FinancialScreen({super.key});

  @override
  State<FinancialScreen> createState() => _FinancialScreenState();
}

class _FinancialScreenState extends State<FinancialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background1,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Financial Service", style: TextStyle(color: AppColor.black)),
      ),
      body: Padding(
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
                              color: AppColor.textPrimary,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColor.textPrimary,
                                width: 2,
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
                      icon: 'assets/people.svg',
                      title: "Financial Service",
                      subtitle : "GML Loan",
                      description: "Loans for only domestic jewellery manufacturers not exporters of jewellery. Loan Borrowers cannot sell the gold to other party to manufacture jewellery"
                    ),
                    SizedBox(height: 6),
                    CardContainer(
                      title: "GML Loan Proposal Documents",
                      description:
                        "Tax Registration (GST). Retail Jewelery Business Registration/Trade Licence Shops and Establishment License. Rent agreement with last rent receipt OR Sale/ Lease Deed agreement. Certified business account statement, Income Tax and Sales Tax Assessment Orders, VAT turnover statement (or GST), or DERS copy and other related papers if any The property offered as a security will be inspected and related documents are verified. No due certificate from existing banker, CERSAI & Credit information reports (CIBIL report etc.) of the proprietor/partners will be examined. Proof of residence like voter card,/Telephone bill, Electricity Bills, Registered lease deed, Sale agreement etc. will be verified before entertaining borrower's request for facility. In case, the applicant is operating his/her account with other banks, Current account original statement is verified. Property offered as security will be inspected and title records Of security offered are investigated."
                    ),
                    SizedBox(height: 6),
                    CardContainer(
                      title: "Bank GML loan",
                      description: 'https://www.rbi.org.in/scripts/BS_ViewMasCirculardetails.aspx?id=9908'
                    ),
                    SizedBox(height: 6),
                    CardContainer(
                      title: "Financial Service",
                      description: ' SBI Bank 7.50%0.50% of the loan amount, minimum Rs.5003 months to 36 months'
                    ),

                    SizedBox(height: 6),
                    CardContainer(
                      title: "Canara Bank",
                      description: 'Canara Bank 7.65%1 % of the loan amount, Min Rs. 1,000 and Max Rs. 5,00012 months'
                    ),

                    SizedBox(height: 6),
                    CardContainer(
                      title: "Federal Bank",
                      description: ' Federal Bank 8.50%Ni16 months to 12 months'
                    ),

                    SizedBox(height: 6),
                    CardContainer(
                        title: "PNB",
                        description: 'PNB 8.75%0.70% of loan amount + taxesl month to 12 months'
                    ),

                    SizedBox(height: 6),
                    CardContainer(
                        title: "HDFC Bank",
                        description: 'HDFC Bank 9.900/01.50% of the loan amount3 months to 24 months'
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
    );
  }
}

class CardContainer extends StatelessWidget {
  String? icon;
  String? title;
  String? subtitle;
  String? description;

  CardContainer({
    super.key,
     this.icon,
     this.title,
    this.subtitle,
     this.description,
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
        color: AppColor.containerBG,
        border: Border.all(color: Color(0xffA6681B)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              icon?.isNotEmpty == true?
              SvgPicture.asset(icon!) : SizedBox.shrink(),
              SizedBox(width: 6),
              title?.isNotEmpty == true ?
              Text(
                title!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColor.subTitle,
                ),
              ) : SizedBox.shrink()
            ],
          ),
          SizedBox(height: 4),
          subtitle != null ?
          Text(
            subtitle!,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColor.subTitle,
            ),
          ) : SizedBox.shrink(),
          SizedBox(height: 6),
          description?.isNotEmpty == true ?
          Text(
            description!,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ) : SizedBox.shrink()
        ],
      ),
    );
  }
}
