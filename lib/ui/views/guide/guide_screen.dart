
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kerala_association/core/res/colors.dart';

class GuideScreen extends StatefulWidget {
  const GuideScreen({super.key});

  @override
  State<GuideScreen> createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background1,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Guide", style: TextStyle(color: AppColor.black)),
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
                      title: "Basic Norms To Open Jewellery",
                      description:
                        "Select the Brand name for the retail business.Get SEA & CORPORATE Licenser GST & PAN Registration. Get a Hallmarking Trademark for the business Get the business enrolled as Private restricted organization Or LLP Jewellery Shops are well known in India and people groups have indicated less interest in purchasing brand adornments and they incline toward neighbourhood ones more. In India, the majority of the Jewellery retail shops are privately-run companies making it an ideal area for setting up an independent venture. Jewellery businesses will in general have a huge turnover easily. Thus, it suggested that gems organizations be enlisted as private restricted organizations to appreciate the advantages of restricted risk insurance, simple adaptability, and that's just the beginning. Further, by joining a private restricted organization for the Jewellery business, assets as obligation or value can be effectively raised."
                    ),
                    SizedBox(height: 6),
                    CardContainer(
                      title: "Shops And Establishment License (SEA)",
                      description:
                        "All organizations are needed to be enlisted under the Shops and Establishments Act with the inspectorate of that region. This should be done inside a months season of setting up the business, ensuing to which an assertion is to be given to the assessor."
                    ),
                    SizedBox(height: 6),
                    CardContainer(
                      title: "Documents For Registration Under The SEA",
                      description:
                        "Commercial Address Proof, Identity Proof, Pan Card, Fee payment Challan.The processing fee for this license is usually between 125 rupees to 12,500 rupees, depending upon the number of employees and manpower you are employing for the business. A jewellery store license shall be issued immediately if all the details in the application are accepted"
                    ),

                    SizedBox(height: 6),
                    CardContainer(
                      title: "Need Send To The Inspector Will Contain",
                      description:
                        "Name of the employer, The name and address of the business including the Postal Address, Category of business, Number of employees employed. Date on which the establishment commenced business."
                    ),

                    SizedBox(height: 6),
                    CardContainer(
                      title: "Application",
                      description: "https://karmamgmt.com/wecheckbetav0.1/acts_pdf/hr/State/Andhra%20Pradesh/The%20Andhra%20Pradesh%20Shops%20And%20Establishments%20Rules%2C%201990.pdf"
                    ),

                    SizedBox(height: 6),
                    CardContainer(
                      title: "Corporate License",
                      description:
                        "Under same administration having more than one Jewellery stores can get a corporate permit covering the entirely of its business outlets. Certain terms and conditions will be material."
                    ),

                    SizedBox(height: 6),
                    CardContainer(
                        title: "List Of Documents To Be Enclosed With The Application",
                        description:
                        "1 ) Self certified copy establishing the Firm: Registration with State Government Authority/ Trade License Or Certificate of Registration issued by Company Registrar or, Registered Partnership Deed in case the applicant is a Partnership Firm Or Certificate from a Chartered Accountant if applicant is a Proprietorship firm. 2 ) Self-certified copy authenticating the Firm's premises (not older than 3 months) Registration with State Government Authority/ Trade Licenses OR Sales Tax/ VAT registration OR, Income Tax Assessment Order OR Insurance Policy OR Property tax receipt OR Rent agreement with last rent receipt OR Sale/ Lease Deed agreement. 3) Documents as identity proof of signatory on the Application Aadhar Card Driving License PAN card Voter Identity card Passport Photo Bank ATM card Photo Credit card CGHS/ECHS photocard The additional documentation required are as follows: Agreement on non-judicial stamp paper of Rs 100/- in the prescribed format. Location map"
                    ),

                    SizedBox(height: 6),
                    CardContainer(
                        title: "BIS Hallmarking",
                        description:
                        "A diamond setter who's interest to sell Hallmarked gold adornments/antiques is needed to get a permit from BIS for specific premises of a jewellery store. The permit is allowed to a jeweller for specific premises if the application in endorsed design alongside essential reports is found all together and instalment of imperative charges and consenting to of an arrangement for working the permit by the goldsmith mutually with BIS. On the off chance that the gem specialist is additionally burning to sell Hallmarked silver gems/relics another permit will be gotten from BIS by presenting a different application and understanding. Hallmarking is the precise assurance and official account of the proportionate substance of valuable metal in the article/gems. Trademark is consequently an authority mark utilized in numerous nations as assurance of virtue or fineness of valuable metal in gems/antiquities. The chief goals of the Hallmarking Scheme are to secure people in general against unacceptable, corrupted items and to commit makers to keep up pronounced immaculateness norms of fineness."
                    ),

                    SizedBox(height: 6),
                    CardContainer(
                        title: "Application FORM",
                        description:
                        "https://bis.gov.in/PDF/lab/ApplicationForm.pdf"
                    ),

                    SizedBox(height: 6),
                    CardContainer(
                        title:"Documents Need to Enclosed with Application",
                        description:
                        "https://www.bis.gov.in/"
                    ),

                    SizedBox(height: 6),
                    CardContainer(
                        title: "Fees Details",
                        description:
                        "https://www.bis.gov.in/"
                    ),

                    SizedBox(height: 6),
                    CardContainer(
                        title: "Guidelines",
                        description:
                        "After grant of licence, the jeweller has to follow the terms and conditions mentioned in the agreement. Deviations in purity of precious metal (gold/silver) and observance of operations not in conformance to stated requirements may result in cancellation of the licence. Proceedings for penalties may also be initiated by BIS."
                    ),

                    SizedBox(height: 6),
                    CardContainer(
                        title: "GST Registration",
                        description:
                        "Sale of Jewelleries is available under GST. Thus, all jewellery businesses must have a GST Registration from the local tax department After getting the GST enlistment the entrepreneurs or business owners can avoid penalties and collect GST charge. Step by step Guide for GST Registration process Online in GST Portal"
                    ),

                    SizedBox(height: 6),
                    CardContainer(
                        title: "Documents Required",
                        description:
                        "PAN card. Aadhaar card. Business address proof. Bank account statement and cancelled cheque. Incorporation Certificate or the business registration proof. Digital Signature. Director's or Promoter's ID proof, address proof, and photograph. Letter of Authorization or Board Resolution from Authorized Signatory. The Step-By-Step Procedure To Complete GST Registration Is Mentioned Below: Step - 1 : Visit the GST portal - https:www.gst.gov.in Step - 2: Click on the 'Register Now' link which can be found under the 'Taxpayers' tab Step - 3: Select 'New Registratiof. Step - 4: Fill the below-mentioned details: Under the 'I am a' drop-down menu, select 'Taxpayer'. Select the respective state and district Enter the name of the business. Enter the PAN of the business, Enter the email ID and mobile number in the respective boxes. The entered email ID and mobile number must be active as OTPs will be sent to them. Enter the image that is shown on the screen and click on 'Proceed'. Step - 5: On the next page, enter the OTP that was sent to the email ID and mobile number in the respective boxes. Step - 6: Once the details have been entered, click on 'Proceed'. Step - 7: You will be shown the Temporary Number (TRN) on the screen. Make a note of the TRN. Step - 8: Visit the GST portal again and click on 'Register' under the Taxpayers' menu. Step - 9: Select 'Temporary Reference Number (TRN)'. Step - 1 0: Enter the TRN and the captcha details. Step - 1 1: Click on 'Proceed', Step - 12 You will receive an OTP on your email ID and registered mobile number, Enter the OTP on the next page and click on 'Proceed'. Step - 1 3: The status of your application will be available on the next page. On the right side, there will be an Edit icon, click on it. Step - 14: There will be IO sections on the next page. All the relevant details must be filled, and the necessary documents must be submitted. The list of documents that must be uploaded are mentioned below: PAN card. Photographs Business address proof Bank details such as account number, bank name, bank branch, and IFSC code. Authorisation form The constitution of the taxpayer. Step - 1 5: Visit the 'Verification' page and check the declaration, Then submit the application by using one of the below mentioned methods: By Electronic Verification Code (EVC). The code will be sent to the registered mobile number. By e-Sign method. An OTP will be sent to the mobile number linked to the Aadhaar card. In case companies are registering, the application must be submitted by using the Digital Signature Certificate (DSC). Step - 1 6: Once completed, a success message will be shown on the screen. The Application Reference Number (ARN) will be sent to the registered mobile number and email ID. Step - 1 7: You can check the status of the ARN on the GST portal."
                    ),

                    SizedBox(height: 6),
                    CardContainer(
                        title: "PAN(Permanent Account Number)",
                        description:
                        "Apply :Documents Require for https://www.incometax.gov.in/iec/foportal/Company Registration: PAN CARD. Pass Port size PhotoGraphs. Aadhaar Card. Rent Agreement. Electricty/Water Bill. Propert Papers. NOC Dosument. Bank Account. DSC and DIN. MOA & AOA Submission. LLP Agreement. DSC(Digital Signature Certificate) Digital Signature Certificates (DSC) is the electronic format of physical or paper certificate Application: http://www.e- mudhra.com/Repository/Forms/Signature-Encryption-Individual-Printable-v2.9.pdf"
                    ),

                    SizedBox(height: 6),
                    CardContainer(
                        title: "Company Registration",
                        description:
                        "A permanent account number (PAN) is a ten-character alphanumeric identifier, issued in the form of a laminated 'PAN card', by the Indian Income Tax Department, to any 'person' who applies for it or to whom the department allots the number without an application. The Step-By-Step Procedure To Complete GST Registration Is Mentioned Below: step 1: open the NSDL (https://www.onlineservices.nsdl.com/paam/endUserRegisterContact.html) to apply for a new PAN. Step 2: Select the Application type - New PAN for Indian citizens, foreign citizens or for change/correction in existing PAN data Step 3: Select your category — individual, associations of persons, a body of individuals, etc. Step 4: Fill in all the required details like name, date of birth, email address and your mobile number in the PAN form. Step 5: On submitting the form, you will get a message regarding the next step. Step 6: Click on the Continue with the PAN Application Form button. Step 7: You will be redirected to the new page where you have to submit your digital e-KYC. Step 8: Select whether you need physical PAN card or not and provide the last four digits of your Aadhaar number. Step 9: Enter your personal details, contact and other details in the next part of the form Step 1 0: Enter your area code, AO Type and other details in this part of the form. Step11 : The last part of the form is the document submission and declaration. Step 12: Enter the first 8 digits of your PAN card to submit the application. You will get to see your completed form.Click Proceed if no modification is required. Step 13: Select the e-KYC option to verify using Aadhaar OTP. For Proof of Identity, Address and Date of Birth, select Aadhaar in all fields and click on Proceed to continue. Step 14: You will be redirected to the payment section where you have to make payment either through demand draft or through net banking/debit/credit card. Step 1 5: A payment receipt will be generated on successful payment. Click on Continue. Step 1 6: Now for Aadhaar Authentication, tick the declaration and select Authenticate option. Step 17: Click on Continue with e-KYC after which an OTP will be sent to the mobile number linked with Aadhaar. Step 18: Enter the OTP and submit the form. Step 19: Now click on Continue with e-Sign after which you will have to enter your 12-digit Aadhaar number. An OTP will be sent to the mobile number linked with Aadhaar. Step 20: Enter OTP and submit the application to get the Acknowledgement slip in pdf having your date of birth as the password in DD/MM/YYYY format."
                    ),

                    SizedBox(height: 6),
                    CardContainer(
                        title: "DIN Number (Director Identification Number)",
                        description:
                        "DIN Number was allotted by the Central Government to any person intending to be a Director or an existing director of a company. It is an 8-digit unique identification number which has a lifetime validity"
                    ),

                    SizedBox(height: 6),
                    CardContainer(
                        title: "To Apply",
                        description:
                        "https://www.mca.gov.in/content/mca/global/en/home.html"
                    ),

                    SizedBox(height: 6),
                    CardContainer(
                        title: "DPIN Number(Designated Partner Identification Number)",
                        description:
                        "All designated partners of the proposed LLP shall obtain Designated Partner Identification Number (DPIN). You need to file eForm DIR-3 in order to obtain DIN or DPIN. In case you already have a DIN (Director Identification Number), the same can be used as a DPIN."
                    ),

                    SizedBox(height: 6),
                    CardContainer(
                        title: "MOA(Memorandum Of Association) & AOA(ArticIe of Association",
                        description:
                        "MOA:Power and Objectives of Company. AOA: Rulles Of Company."
                    ),

                    SizedBox(height: 6),
                    CardContainer(
                        title: "Instrucation Kit for MOA:",
                        description:
                        "https://www.mca.gov.in/MinistryLpdf/SPlCe+_%20MoA_%20help.pdf"
                    ),

                    SizedBox(height: 6),
                    CardContainer(
                        title: "Goverment site links",
                        description:
                       "Government site links BlS(Bureau Of Indian Standards) https://www.bis.gov.in/"
                    ),

                    SizedBox(height: 6),
                    CardContainer(
                        title: "GST(Goods and Service Tax)",
                        description:
                        "https://www.gst.gov.in/"
                    ),

                    SizedBox(height: 6),
                    CardContainer(
                        title: "MSME(Ministry Of Micro, Small & Medium enterprises) ",
                        description:
                        "https://msme.gov.in/"
                    ),

                    SizedBox(height: 6),
                    CardContainer(
                        title: "PAN",
                        description:
                        "https://www.pan.utiitsl.com/"
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
              Expanded (
                child: Text(
                  title!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColor.subTitle,
                  ),
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
