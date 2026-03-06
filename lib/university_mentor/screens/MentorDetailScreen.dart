import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MentorDetailScreen extends StatelessWidget {
  final Map<String, String> mentorData;

  const MentorDetailScreen({super.key, required this.mentorData});

  static const Color primaryBlue = Color(0xFF64A9F6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      extendBodyBehindAppBar: true,

      /// APPBAR
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      /// BODY
      body: SingleChildScrollView(
        child: Column(
          children: [

            /// TOP PROFILE HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 90, bottom: 40),
              decoration: const BoxDecoration(
                color: primaryBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),

              child: Column(
                children: [

                  /// PROFILE IMAGE
                  Hero(
                    tag: mentorData['name'] ?? 'mentor',
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 56,
                        backgroundImage: NetworkImage(
                          mentorData['img'] ?? "https://i.pravatar.cc/150",
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// NAME
                  Text(
                    mentorData['name'] ?? "Unknown Mentor",
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// DESIGNATION
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.25),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      mentorData['designation'] ?? "Faculty Member",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            /// DETAILS
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// FACULTY INFO
                  _buildSectionTitle("Faculty Information"),
                  _buildDetailCard([
                    _buildRow(
                        Icons.badge_outlined,
                        "Faculty ID",
                        mentorData['id'] ?? "Not Assigned"),
                    _buildRow(Icons.account_tree_outlined, "Department",
                        mentorData['dept'] ?? "Not Specified"),
                    _buildRow(Icons.workspace_premium_outlined, "Designation",
                        mentorData['designation'] ?? "Professor"),
                  ]),

                  const SizedBox(height: 20),

                  /// CONTACT INFO
                  _buildSectionTitle("Contact Details"),
                  _buildDetailCard([
                    _buildRow(Icons.email_outlined, "Email",
                        mentorData['email'] ?? "Not Provided"),
                    _buildRow(Icons.phone_android_outlined, "Phone",
                        mentorData['phone'] ?? "Not Provided"),
                  ]),

                  const SizedBox(height: 20),

                  /// STUDENT SUPERVISION
                  _buildSectionTitle("Student Oversight"),
                  _buildDetailCard([
                    _buildRow(Icons.groups_outlined, "Total Students",
                        mentorData['totalStudents'] ?? "0"),
                    _buildRow(Icons.business_center_outlined,
                        "Internship Companies", mentorData['companies'] ?? "0"),
                  ]),

                  const SizedBox(height: 30),

                  /// EMAIL BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.send),
                      label: const Text(
                        "SEND EMAIL",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      onPressed: () {
                        _launchEmail(mentorData['email']);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// SECTION TITLE
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey.shade400,
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  /// CARD CONTAINER
  Widget _buildDetailCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  /// INFO ROW
  Widget _buildRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [

          /// ICON
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primaryBlue.withOpacity(.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: primaryBlue, size: 20),
          ),

          const SizedBox(width: 15),

          /// TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// EMAIL LAUNCHER
  Future<void> _launchEmail(String? email) async {
    if (email == null || email.isEmpty) return;

    final Uri url = Uri.parse("mailto:$email");

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
}