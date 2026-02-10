import 'package:flutter/material.dart';
import '../../../models/student_draft.dart';

class AcademicDetailsScreen extends StatefulWidget {
  const AcademicDetailsScreen({super.key});

  @override
  State<AcademicDetailsScreen> createState() => _AcademicDetailsScreenState();
}

class _AcademicDetailsScreenState extends State<AcademicDetailsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final _formKey = GlobalKey<FormState>();
  final Color primaryBlue = const Color(0xFF1976D2);

  // Controllers (prefilled)
  final TextEditingController collegeController =
      TextEditingController(text: StudentDraft.college);
  final TextEditingController courseController =
      TextEditingController(text: StudentDraft.course);
  final TextEditingController semesterController =
      TextEditingController(text: StudentDraft.semester);
  final TextEditingController marksController =
      TextEditingController(text: StudentDraft.marks);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _animation = Tween<double>(begin: -200, end: 200).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// SAVE INTO DRAFT
  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      StudentDraft.college = collegeController.text.trim();
      StudentDraft.course = courseController.text.trim();
      StudentDraft.semester = semesterController.text.trim();
      StudentDraft.marks = marksController.text.trim();

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🔁 BACKGROUND
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_animation.value, 0),
                child: child,
              );
            },
            child: OverflowBox(
              maxWidth: MediaQuery.of(context).size.width * 2,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 2,
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  'assets/images/collage_bg.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          /// 🔷 UI
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 50),

                      Icon(Icons.school, size: 60, color: primaryBlue),
                      const SizedBox(height: 10),
                      Text(
                        "Academic Details",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryBlue,
                        ),
                      ),

                      const SizedBox(height: 30),

                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 480),
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE3F2FD),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              _inputField(
                                "College Name",
                                collegeController,
                                Icons.account_balance,
                                validator: (v) =>
                                    v!.isEmpty ? "Required" : null,
                              ),
                              _inputField(
                                "Course",
                                courseController,
                                Icons.book,
                                validator: (v) =>
                                    v!.isEmpty ? "Required" : null,
                              ),
                              _inputField(
                                "Current Semester",
                                semesterController,
                                Icons.timeline,
                                keyboard: TextInputType.number,
                                validator: _validateSemester,
                              ),
                              _inputField(
                                "Last Year Marks (%)",
                                marksController,
                                Icons.score,
                                keyboard: TextInputType.number,
                                validator: _validateMarks,
                              ),

                              const SizedBox(height: 24),

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _saveForm,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryBlue,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    "Save & Go Back",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputField(
    String label,
    TextEditingController controller,
    IconData icon, {
    TextInputType keyboard = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(icon, color: primaryBlue),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  String? _validateSemester(String? value) {
    if (value == null || value.isEmpty) return "Required";
    final sem = int.tryParse(value);
    if (sem == null || sem < 1 || sem > 12) {
      return "Enter valid semester (1–12)";
    }
    return null;
  }

  String? _validateMarks(String? value) {
    if (value == null || value.isEmpty) return "Required";
    final marks = double.tryParse(value);
    if (marks == null || marks < 0 || marks > 100) {
      return "Enter marks between 0–100";
    }
    return null;
  }
}