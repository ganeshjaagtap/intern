import 'package:flutter/material.dart';

class MentorScreen extends StatefulWidget {
  const MentorScreen({super.key});

  @override
  State<MentorScreen> createState() => _MentorScreenState();
}

class _MentorScreenState extends State<MentorScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _allMentors = [
    {"name": "Dr. R. Shinde", "email": "jassicarobert@gmail.com", "img": "https://i.pravatar.cc/150?u=1"},
    {"name": "Carol Sons", "email": "carolsons@gmail.com", "img": "https://i.pravatar.cc/150?u=2"},
    {"name": "Robert Jason", "email": "robertjason@gmail.com", "img": "https://i.pravatar.cc/150?u=3"},
    {"name": "Williams Jones", "email": "williamsjones@gmail.com", "img": "https://i.pravatar.cc/150?u=4"},
    {"name": "Robert Jason", "email": "robertjason@gmail.com", "img": "https://i.pravatar.cc/150?u=6"},
    {"name": "Robert Jason", "email": "robertjason@gmail.com", "img": "https://i.pravatar.cc/150?u=7"},
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
          /// 📘 BLUE SEARCH HEADER (Matches Photo)
          Container(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
            decoration: const BoxDecoration(
              color: primaryBlue,
            ),
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
                    icon: Icon(Icons.search, color: Colors.black87),
                    hintText: "Search company",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),

          /// ⚪ ALLOCATED MENTORS TITLE BAR (Matches Photo)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Text(
              "Allocated Mentor's",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          /// 📜 LIST VIEW
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemCount: _filteredMentors.length,
              itemBuilder: (context, index) {
                return _buildMentorCard(_filteredMentors[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMentorCard(Map<String, String> mentor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: Colors.grey.shade200,
          backgroundImage: NetworkImage(mentor['img']!),
        ),
        title: Text(
          mentor['name']!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          mentor['email']!,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
      ),
    );
  }
}