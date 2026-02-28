import 'package:flutter/material.dart';

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({super.key});

  @override
  State<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> companies = [
    {"name": "Jassica Robert", "email": "jassicarobert@gmail.com"},
    {"name": "Carol Sons", "email": "carolsons@gmail.com"},
    {"name": "Robert Jason", "email": "robertjason@gmail.com"},
    {"name": "Williams Jones", "email": "williamsjones@gmail.com"},
    {"name": "Carol Sons", "email": "carolsons@gmail.com"},
    {"name": "Robert Jason", "email": "robertjason@gmail.com"},
    {"name": "Williams Jones", "email": "williamsjones@gmail.com"},
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF64A9F6); // Match the exact sky blue
    const bgLight = Color(0xFFF5F7F9);    // Professional light gray background

    return Container(
      color: bgLight,
      child: Column(
        children: [
          /// 📘 BLUE SEARCH HEADER (Matches Photo Style)
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
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search, color: Colors.black54),
                    hintText: "Search company",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),

          /// ⚪ TITLE BAR (White rounded container from photo)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                )
              ]
            ),
            child: const Text(
              "Authenticated Companies",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          /// 🏢 SCROLLABLE LIST
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              itemCount: companies.length,
              itemBuilder: (context, index) {
                return _buildCompanyCard(companies[index], primaryBlue);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyCard(Map<String, String> company, Color themeColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25), // Rounded corners like photo
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
          backgroundColor: themeColor.withOpacity(0.1),
          child: Icon(Icons.business, color: themeColor),
        ),
        title: Text(
          company["name"]!,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          company["email"]!,
          style: TextStyle(color: Colors.grey.shade600),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {
          // Add navigation logic
        },
      ),
    );
  }
}