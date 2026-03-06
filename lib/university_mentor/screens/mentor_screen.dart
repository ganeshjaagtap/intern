import 'package:flutter/material.dart';
import 'MentorDetailScreen.dart'; 

class MentorScreen extends StatefulWidget {
  const MentorScreen({super.key});

  @override
  State<MentorScreen> createState() => _MentorScreenState();
}

class _MentorScreenState extends State<MentorScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _allMentors = [
    {
      "name": "Dr. R. Shinde",
      "id": "EMP101",
      "dept": "Computer Engineering",
      "designation": "Professor",
      "email": "jassicarobert@gmail.com",
      "phone": "+91 9876543210",
      "totalStudents": "12",
      "companies": "Google, Amazon, TCS",
      "img": "https://i.pravatar.cc/150?u=1"
    },
    {
      "name": "Carol Sons",
      "id": "EMP102",
      "dept": "Information Technology",
      "designation": "Assistant Professor",
      "email": "carolsons@gmail.com",
      "phone": "+91 9876543211",
      "totalStudents": "8",
      "companies": "Tesla, Microsoft",
      "img": "https://i.pravatar.cc/150?u=2"
    },
    {
      "name": "Robert Jason",
      "id": "EMP103",
      "dept": "Mechanical Engineering",
      "designation": "Lecturer",
      "email": "robertjason@gmail.com",
      "phone": "+91 9876543212",
      "totalStudents": "10",
      "companies": "BMW, Ford",
      "img": "https://i.pravatar.cc/150?u=3"
    },
  ];

  List<Map<String, String>> _filteredMentors = [];

  @override
  void initState() {
    super.initState();
    _filteredMentors = _allMentors;
  }

  void _filterMentors(String query) {
    setState(() {
      _filteredMentors = _allMentors
          .where((m) => m['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF64A9F6);
    const bgLight = Color(0xFFF5F7F9);

    return Scaffold(
      backgroundColor: bgLight,
      body: Column(
        children: [
          /// 📘 HEADER
          Container(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
            decoration: const BoxDecoration(color: primaryBlue),
            child: SafeArea(
              bottom: false,
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: _filterMentors,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search, color: primaryBlue),
                    hintText: "Search mentor...",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),

          /// ⚪ TITLE BAR
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Text(
              "Allocated Mentors",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          /// 📜 LIST VIEW
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              itemCount: _filteredMentors.length,
              itemBuilder: (context, index) {
                final mentor = _filteredMentors[index];
                return _buildMentorCard(mentor, primaryBlue);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMentorCard(Map<String, String> mentor, Color themeColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      // 💡 Material & InkWell ensure the tap is felt across the whole card
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {
            debugPrint("Navigating to detail for: ${mentor['name']}");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MentorDetailScreen(mentorData: mentor),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Hero(
                  tag: mentor['name']!, // Matches tag in Detail Screen
                  child: CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(mentor['img']!),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mentor['name']!,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        mentor['email']!,
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}