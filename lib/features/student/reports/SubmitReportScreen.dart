import 'package:flutter/material.dart';

class SubmitReportScreen extends StatefulWidget {
  const SubmitReportScreen({Key? key}) : super(key: key);

  @override
  State<SubmitReportScreen> createState() => _SubmitReportScreenState();
}

class _SubmitReportScreenState extends State<SubmitReportScreen> {
  final _formKey = GlobalKey<FormState>();

  String reportType = "Weekly";
  String selectedWeek = "Week 1";
  DateTime? fromDate;
  DateTime? toDate;

  final TextEditingController summaryCtrl = TextEditingController();
  final TextEditingController workDoneCtrl = TextEditingController();
  final TextEditingController learningCtrl = TextEditingController();
  final TextEditingController issuesCtrl = TextEditingController();
  final TextEditingController nextPlanCtrl = TextEditingController();

  final List<String> weeks = [
    "Week 1",
    "Week 2",
    "Week 3",
    "Week 4",
  ];

  Future<void> _pickDate(bool isFrom) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  void _submitReport() {
    if (!_formKey.currentState!.validate()) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Report submitted successfully"),
      ),
    );

    Navigator.pop(context);
  }

  void _saveDraft() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Draft saved"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6BB6FF),
        title: const Text("SUBMIT REPORT"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// =========================
              /// STUDENT INFO
              /// =========================
              _sectionTitle("Student Information"),
              _card(
                Column(
                  children: const [
                    _infoRow("Name", "Abhijeet Apare"),
                    _infoRow("Department", "Computer Science"),
                    _infoRow("Role", "Flutter Developer Intern"),
                    _infoRow("Mentor", "Dr. Sharma"),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// =========================
              /// REPORT TYPE
              /// =========================
              _sectionTitle("Report Details"),
              _card(
                Column(
                  children: [
                    DropdownButtonFormField<String>(
                      value: reportType,
                      decoration: const InputDecoration(
                        labelText: "Report Type",
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: "Weekly", child: Text("Weekly Report")),
                        DropdownMenuItem(
                            value: "Monthly", child: Text("Monthly Report")),
                      ],
                      onChanged: (v) {
                        if (v != null) setState(() => reportType = v);
                      },
                    ),

                    const SizedBox(height: 12),

                    if (reportType == "Weekly")
                      DropdownButtonFormField<String>(
                        value: selectedWeek,
                        decoration: const InputDecoration(
                          labelText: "Week",
                          border: OutlineInputBorder(),
                        ),
                        items: weeks
                            .map((w) => DropdownMenuItem(
                                  value: w,
                                  child: Text(w),
                                ))
                            .toList(),
                        onChanged: (v) {
                          if (v != null) setState(() => selectedWeek = v);
                        },
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// =========================
              /// DATE RANGE
              /// =========================
              _sectionTitle("Date Range"),
              _card(
                Row(
                  children: [
                    Expanded(
                      child: _dateField(
                        label: "From Date",
                        value: fromDate,
                        onTap: () => _pickDate(true),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _dateField(
                        label: "To Date",
                        value: toDate,
                        onTap: () => _pickDate(false),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// =========================
              /// REPORT CONTENT
              /// =========================
              _sectionTitle("Report Content"),
              _card(
                Column(
                  children: [
                    _textField(
                      controller: summaryCtrl,
                      label: "Summary",
                      hint: "Brief summary of the week",
                    ),
                    const SizedBox(height: 12),
                    _textField(
                      controller: workDoneCtrl,
                      label: "Work Done",
                      hint: "Tasks completed during this period",
                      maxLines: 4,
                    ),
                    const SizedBox(height: 12),
                    _textField(
                      controller: learningCtrl,
                      label: "Learning Outcomes",
                      hint: "What you learned",
                      maxLines: 3,
                    ),
                    const SizedBox(height: 12),
                    _textField(
                      controller: issuesCtrl,
                      label: "Issues / Challenges",
                      hint: "Problems faced (if any)",
                      maxLines: 3,
                    ),
                    const SizedBox(height: 12),
                    _textField(
                      controller: nextPlanCtrl,
                      label: "Next Week Plan",
                      hint: "Planned tasks",
                      maxLines: 3,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// =========================
              /// FILE UPLOAD (UI ONLY)
              /// =========================
              _sectionTitle("Attachments"),
              _card(
                Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.attach_file),
                      title: const Text("Attach supporting files"),
                      subtitle:
                          const Text("PDF / DOC / Images (optional)"),
                      trailing: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("File picker coming soon"),
                            ),
                          );
                        },
                        child: const Text("Upload"),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// =========================
              /// ACTION BUTTONS
              /// =========================
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _saveDraft,
                      child: const Text("Save Draft"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6BB6FF),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: _submitReport,
                      child: const Text("Submit Report"),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  /// =========================
  /// REUSABLE WIDGETS
  /// =========================

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _card(Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: child,
    );
  }

  Widget _dateField({
    required String label,
    required DateTime? value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        child: Text(
          value == null
              ? "Select date"
              : "${value.day}/${value.month}/${value.year}",
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 2,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: (v) =>
          v == null || v.isEmpty ? "This field is required" : null,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

/// =========================
/// SMALL WIDGETS
/// =========================

class _infoRow extends StatelessWidget {
  final String label;
  final String value;

  const _infoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
