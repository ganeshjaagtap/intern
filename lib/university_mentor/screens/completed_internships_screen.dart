import 'package:flutter/material.dart';

class CompletedInternshipsScreen extends StatelessWidget {
  const CompletedInternshipsScreen({super.key});

  final List<Map<String, String>> students = const [
    {
      "name": "Aditya Verma",
      "company": "Infosys",
      "role": "Flutter Developer"
    },
    {
      "name": "Sanya Malhotra",
      "company": "TCS",
      "role": "Web Developer"
    },
    {
      "name": "Rahul Deshmukh",
      "company": "Wipro",
      "role": "Backend Developer"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Completed Internships"),
      ),

      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {

          final student = students[index];

          return Card(
            margin: const EdgeInsets.all(10),

            child: ListTile(
              leading: CircleAvatar(
                child: Text(student["name"]![0]),
              ),

              title: Text(student["name"]!),

              subtitle: Text(
                "${student["company"]} • ${student["role"]}",
              ),

              trailing: const Text(
                "Completed",
                style: TextStyle(color: Colors.green),
              ),
            ),
          );
        },
      ),
    );
  }
}