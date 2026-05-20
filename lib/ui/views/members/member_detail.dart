
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kerala_association/common_widget/common_button.dart';
import 'package:kerala_association/core/model/member_list_response.dart';
import 'package:kerala_association/core/res/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Member {
  final String name;
  final String company;
  final String role;
  final String imageUrl;
  final String phoneNumber;
  final String email;
  final String address;
  final String district;
  final String category;
  final String companyProfile;

  const Member({
    required this.name,
    required this.company,
    required this.role,
    required this.imageUrl,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.district,
    required this.category,
    required this.companyProfile,
  });
}

class MemberDetail extends StatefulWidget {
  final MemberListData member;
  const MemberDetail({super.key, required this.member});

  @override
  State<MemberDetail> createState() => _MemberDetailState();
}

class _MemberDetailState extends State<MemberDetail> {
  Future<void> _launchUrlHelper(BuildContext context, Uri url, String fallbackMessage) async {
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(fallbackMessage)));
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An error occurred: $e")));
      }
    }
  }

  void _openWhatsApp(BuildContext context) {
    final String phoneNumber = widget.member.mobileNumber!;
    final String message = Uri.encodeComponent("Hello! I'm interested in your service.");
    final Uri url = Uri.parse("https://wa.me/$phoneNumber?text=$message");
    _launchUrlHelper(context, url, "Could not launch WhatsApp.");
  }

  void _openDialer(BuildContext context) {
    final String phoneNumber = widget.member.mobileNumber!;
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    _launchUrlHelper(context, url, "Could not launch dialer.");
  }

  void _openEmail(BuildContext context) {
    final String email = widget.member.emailID!;
    final Uri url = Uri(scheme: 'mailto', path: email);
    _launchUrlHelper(context, url, "Could not launch email client.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Member Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            const Text(
              "Further Information:",
              style: TextStyle(fontSize: 18, color: AppColor.primary),
            ),
            _InfoTile(
              icon: SvgPicture.asset("assets/company_type.svg"),
              label: "Company Profile",
              value: widget.member.profile!,
            ),
            if (_hasValue(widget.member.emailID))
              _InfoTile(
                icon: const Icon(Icons.email_outlined,
                    color: AppColor.textDisable, size: 22),
                label: "Email",
                value: widget.member.emailID!,
                onTap: () => _openEmail(context),
              ),

            if (_hasValue(widget.member.address))
              _InfoTile(
                icon: const Icon(Icons.location_on_outlined,
                    color: AppColor.textDisable, size: 22),
                label: "Address",
                value: widget.member.address!,
              ),

            if (_hasValue(widget.member.district))
              _InfoTile(
                icon: const Icon(Icons.map_outlined,
                    color: AppColor.textDisable, size: 22),
                label: "District",
                value: widget.member.district!,
              ),

          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 24),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: widget.member.memberPhotoURL!,
              fit: BoxFit.cover,
              width: 150,
              height: 150,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
              errorWidget: (context, url, error) => Image.asset('assets/logo.png', fit: BoxFit.cover),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(widget.member.memberName!, style: const TextStyle(fontSize: 24,)),
        const SizedBox(height: 4),
        Text(widget.member.companyName!, style: const TextStyle(fontSize: 18, color: AppColor.secondary)),
        const SizedBox(height: 4),
        Text(widget.member.profile!, style: const TextStyle(fontSize: 18, color: AppColor.textDisable)),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: CommonButton(
                text: "Whatsapp",
                isOutlined: true,
                isFilled: false,
                suffixIcon: SvgPicture.asset("assets/whatsapp.svg"),
                borderRadius: BorderRadius.circular(40),
                onPressed: () => _openWhatsApp(context),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CommonButton(
                text: "Contact",
                suffixIcon: const Icon(Icons.phone, color: AppColor.white, size: 24),
                borderRadius: BorderRadius.circular(40),
                onPressed: () => _openDialer(context),
              ),
            ),
          ],
        ),
      ],
    );
  }

  bool _hasValue(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

}

class _InfoTile extends StatelessWidget {
  final Widget icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isClickable = onTap != null;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 24, height: 24, child: Center(child: icon)),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: const TextStyle(fontSize: 16, color: AppColor.textDisable),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 34.0),
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 17,
                  color: isClickable ? AppColor.secondary : Colors.black,
                  decoration: isClickable ? TextDecoration.underline : null,
                  decorationColor: AppColor.secondary,
                ),
              ),
            ),
            const Divider(height: 24, thickness: 0.5),
          ],
        ),
      ),
    );
  }
}
