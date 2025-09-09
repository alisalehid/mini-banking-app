import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image

            SizedBox(height: 100,) ,
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  "assets/images/bankb.jpg", // Mock image
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Company Name
            const Text(
              "Mini Banking App Inc.",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Tagline
            const Text(
              "Empowering Your Finances with Simplicity",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const Divider(height: 32),

            // About section
            const Text(
              "Who We Are",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              "Mini Banking App Inc. is a mock fintech startup founded in 2023 with a vision "
                  "to make personal finance management simple, secure, and accessible. "
                  "Our passionate team of developers, designers, and financial experts "
                  "work together to deliver innovative solutions for modern banking needs.",
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 24),

            const Text(
              "Our Mission",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              "To provide easy-to-use, transparent, and reliable digital financial services "
                  "that empower individuals and businesses to take control of their money.",
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 24),

            const Text(
              "Meet the Team",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            // Team section mock
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                  NetworkImage("https://i.pravatar.cc/150?img=1"),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    "Alice Johnson - CEO & Co-Founder\n"
                        "Alice is passionate about financial literacy and "
                        "creating user-friendly digital products.",
                    style: TextStyle(fontSize: 14, height: 1.3),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                  NetworkImage("https://i.pravatar.cc/150?img=2"),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    "Michael Smith - CTO & Co-Founder\n"
                        "Michael specializes in mobile development and "
                        "secure digital banking infrastructure.",
                    style: TextStyle(fontSize: 14, height: 1.3),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Footer
            Center(
              child: Column(
                children: const [
                  Text(
                    "© 2025 Mini Banking App Inc.",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "All rights reserved.",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
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
