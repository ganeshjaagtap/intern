import 'package:flutter/material.dart';
import '../../../models/student_draft.dart';

class SkillsInterestsScreen extends StatefulWidget {
  const SkillsInterestsScreen({super.key});

  @override
  State<SkillsInterestsScreen> createState() =>
      _SkillsInterestsScreenState();
}

class _SkillsInterestsScreenState extends State<SkillsInterestsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final _formKey = GlobalKey<FormState>();
  final Color primaryBlue = const Color(0xFF1976D2);

  // Controllers (prefilled)
  final TextEditingController technicalSkillsController =
      TextEditingController(text: StudentDraft.technicalSkills);
  final TextEditingController softSkillsController =
      TextEditingController(text: StudentDraft.softSkills);
  final TextEditingController interestsController =
      TextEditingController(text: StudentDraft.interests);
  final TextEditingController careerGoalController =
      TextEditingController(text: StudentDraft.careerGoal);

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
      StudentDraft.technicalSkills =
          technicalSkillsController.text.trim();
      StudentDraft.softSkills =
          softSkillsController.text.trim();
      StudentDraft.interests =
          interestsController.text.trim();
      StudentDraft.careerGoal =
          careerGoalController.text.trim();

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
              maxWidth: MediaQuery.of(context).size.width * 1.5,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 1.5,
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

                      Icon(Icons.star, size: 60, color: primaryBlue),
                      const SizedBox(height: 10),
                      Text(
                        "Skills & Interests",
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
                                "Technical Skills",
                                technicalSkillsController,
                                Icons.code,
                                hint: "e.g. Flutter, Java, Python",
                                validator: (v) =>
                                    v!.isEmpty ? "Required" : null,
                              ),
                              _inputField(
                                "Soft Skills",
                                softSkillsController,
                                Icons.record_voice_over,
                                hint:
                                    "e.g. Communication, Teamwork",
                                validator: (v) =>
                                    v!.isEmpty ? "Required" : null,
                              ),
                              _inputField(
                                "Area of Interest",
                                interestsController,
                                Icons.interests,
                                hint:
                                    "e.g. Mobile Development",
                                validator: (v) =>
                                    v!.isEmpty ? "Required" : null,
                              ),
                              _inputField(
                                "Career Goal",
                                careerGoalController,
                                Icons.flag,
                                hint: "Your future goal",
                                maxLines: 2,
                                validator: (v) =>
                                    v!.isEmpty ? "Required" : null,
                              ),

                              const SizedBox(height: 24),

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _saveForm,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryBlue,
                                    padding:
                                        const EdgeInsets.symmetric(
                                            vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    "Save & Go Back",
                                    style:
                                        TextStyle(color: Colors.black),
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
    String? hint,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
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
}
