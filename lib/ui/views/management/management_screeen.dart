import 'package:flutter/material.dart';
import 'package:kerala_association/core/res/colors.dart';

class ManagementScreen extends StatelessWidget {
  const ManagementScreen({super.key});

  final List<Map<String, String>> leaders = const [
    {
      "image": "assets/surendran.png",
      "name": "K. Surendran",
      "role": "State President",
    },
    {
      "image": "assets/abdul_nazar.png",
      "name": "Sri. Shantilal Jain",
      "role": "General Secretary",
    },
    {
      "image": "assets/krishnadas.png",
      "name": "C. V. Krishnadas",
      "role": "Treasurer",
    },
    {
      "image": "assets/ayamu.png",
      "name": "P. K. Ayamu Haji",
      "role": "Working President",
    },
    {
      "image": "assets/premanand.png",
      "name": "B. Premanand",
      "role": "Working Gen. Secretary",
    },
    {
      "image": "assets/vineeth.png",
      "name": "M. Vineeth",
      "role": "Working Gen. Secretary",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 600;

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        elevation: 0,
        title: Text(
          "Management",
          style: TextStyle(color: AppColor.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset("assets/app_logo.png", height: 100)),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  "KGSMA",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColor.green,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Executive Board",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppColor.green,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Meet the visionaries who built this community from the ground up",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 20),

              // Responsive grid layout
              GridView.builder(
                itemCount: leaders.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isWide ? 3 : 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final leader = leaders[index];
                  return LeaderCard(
                    imagePath: leader["image"]!,
                    name: leader["name"]!,
                    role: leader["role"]!,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LeaderCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String role;

  const LeaderCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColor.secondary),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Image.network(
                    'https://cdn.vectorstock.com/i/500p/29/52/faceless-male-avatar-in-hoodie-vector-56412952.jpg',
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColor.secondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            role,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.subTitle,
            ),
          ),
        ],
      ),
    );
  }
}
