import 'package:flutter/material.dart';
import 'faculty_details_screen.dart';
import 'company_approvals.dart';

class ReviewApprovalsScreen extends StatefulWidget {
  const ReviewApprovalsScreen({super.key});

  @override
  State<ReviewApprovalsScreen> createState() => _ReviewApprovalsScreenState();
}

class _ReviewApprovalsScreenState extends State<ReviewApprovalsScreen>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;

  /// Faculty Requests
  final List<Map<String, String>> facultyRequests = [
    {
      "name": "Prof. Patil",
      "empId": "FAC102",
      "department": "IoT",
      "designation": "Assistant Professor",
      "email": "patil@college.com",
      "phone": "9876543210",
      "status": "Pending"
    },
    {
      "name": "Prof. Sharma",
      "empId": "FAC103",
      "department": "Computer",
      "designation": "Assistant Professor",
      "email": "sharma@college.com",
      "phone": "9876543211",
      "status": "Pending"
    },
  ];

  /// Company Requests
  final List<Map<String, String>> companyRequests = [
    {
      "company": "Infosys",
      "industry": "IT Services",
      "location": "Pune",
      "website": "www.infosys.com",
      "hrName": "Rajesh Kumar",
      "hrEmail": "hr@infosys.com",
      "hrPhone": "9876543212",
      "role": "Flutter Developer",
      "type": "Hybrid",
      "duration": "3 Months",
      "start": "01 June 2026",
      "end": "31 Aug 2026",
      "stipend": "₹10,000/month",
      "students": "5",
      "department": "IoT",
      "cgpa": "7.0",
      "skills": "Flutter, Dart"
    },
    {
      "company": "TCS",
      "industry": "IT Services",
      "location": "Mumbai",
      "website": "www.tcs.com",
      "hrName": "Anita Sharma",
      "hrEmail": "hr@tcs.com",
      "hrPhone": "9876543213",
      "role": "Web Developer",
      "type": "Online",
      "duration": "3 Months",
      "start": "10 June 2026",
      "end": "10 Sep 2026",
      "stipend": "₹8,000/month",
      "students": "4",
      "department": "Computer",
      "cgpa": "6.5",
      "skills": "HTML, CSS, JavaScript"
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void approve(String name) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("$name Approved")));
  }

  void reject(String name) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("$name Rejected")));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Review Approvals"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Faculty"),
            Tab(text: "Companies"),
          ],
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: [

          /// FACULTY TAB
          ListView.builder(
            itemCount: facultyRequests.length,
            itemBuilder: (context, index) {

              final faculty = facultyRequests[index];

              return Card(
                margin: const EdgeInsets.all(10),

                child: ListTile(

                  leading: const Icon(Icons.person),

                  title: Text(faculty["name"]!),

                  subtitle: Text(
                      "${faculty["department"]} • ${faculty["email"]}"),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      IconButton(
                        icon: const Icon(Icons.check, color: Colors.green),
                        onPressed: () => approve(faculty["name"]!),
                      ),

                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () => reject(faculty["name"]!),
                      ),
                    ],
                  ),

                  /// OPEN FACULTY DETAILS
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FacultyDetailsScreen(faculty: faculty),
                      ),
                    );
                  },
                ),
              );
            },
          ),

          /// COMPANY TAB
          ListView.builder(
            itemCount: companyRequests.length,
            itemBuilder: (context, index) {

              final company = companyRequests[index];

              return Card(
                margin: const EdgeInsets.all(10),

                child: ListTile(

                  leading: const Icon(Icons.business),

                  title: Text(company["company"]!),

                  subtitle:
                      Text("${company["role"]} • ${company["location"]}"),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      IconButton(
                        icon: const Icon(Icons.check, color: Colors.green),
                        onPressed: () => approve(company["company"]!),
                      ),

                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () => reject(company["company"]!),
                      ),
                    ],
                  ),

                  /// OPEN COMPANY DETAILS
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CompanyApprovalsScreen(company: company),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}