import 'package:flutter/material.dart';
import '../../../models/student_draft.dart';

class BasicInfoScreen extends StatefulWidget {
  const BasicInfoScreen({super.key});

  @override
  State<BasicInfoScreen> createState() => _BasicInfoScreenState();
}

class _BasicInfoScreenState extends State<BasicInfoScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final _formKey = GlobalKey<FormState>();
  final Color primaryBlue = const Color(0xFF1976D2);

  // Controllers (pre-filled if user revisits screen)
  final TextEditingController fullNameController =
      TextEditingController(text: StudentDraft.fullName);
  final TextEditingController enrollmentController =
      TextEditingController(text: StudentDraft.enrollmentNo);
  final TextEditingController emailController =
      TextEditingController(text: StudentDraft.email);
  final TextEditingController mobileController =
      TextEditingController(text: StudentDraft.mobile);
  final TextEditingController dobController =
      TextEditingController(text: StudentDraft.dob);
  final TextEditingController cityController =
      TextEditingController(text: StudentDraft.city);

  String gender = StudentDraft.gender ?? "Male";

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

  /// SAVE DATA INTO DRAFT MODEL
  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      StudentDraft.fullName = fullNameController.text.trim();
      StudentDraft.enrollmentNo = enrollmentController.text.trim();
      StudentDraft.email = emailController.text.trim();
      StudentDraft.mobile = mobileController.text.trim();
      StudentDraft.dob = dobController.text.trim();
      StudentDraft.gender = gender;
      StudentDraft.city = cityController.text.trim();

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🔁 BACKGROUND ANIMATION
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

                      Icon(Icons.person, size: 60, color: primaryBlue),
                      const SizedBox(height: 10),
                      Text(
                        "Basic Information",
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
                                "Full Name",
                                fullNameController,
                                Icons.person,
                                validator: (v) =>
                                    v!.isEmpty ? "Required" : null,
                              ),
                              _inputField(
                                "Enrollment Number",
                                enrollmentController,
                                Icons.confirmation_number,
                                validator: (v) =>
                                    v!.isEmpty ? "Required" : null,
                              ),
                              _inputField(
                                "Email ID",
                                emailController,
                                Icons.email,
                                validator: _validateEmail,
                              ),
                              _inputField(
                                "Mobile Number",
                                mobileController,
                                Icons.phone,
                                keyboard: TextInputType.phone,
                                validator: _validateMobile,
                              ),
                              _inputField(
                                "Date of Birth",
                                dobController,
                                Icons.calendar_today,
                                readOnly: true,
                                onTap: _pickDate,
                                validator: (v) =>
                                    v!.isEmpty ? "Select DOB" : null,
                              ),

                              /// GENDER
                              DropdownButtonFormField<String>(
                                value: gender,
                                items: ["Male", "Female", "Other"]
                                    .map(
                                      (g) => DropdownMenuItem(
                                        value: g,
                                        child: Text(g),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  setState(() => gender = value!);
                                },
                                validator: (v) =>
                                    v == null ? "Select gender" : null,
                                decoration: _decoration(
                                  "Gender",
                                  Icons.person_outline,
                                ),
                              ),

                              const SizedBox(height: 16),

                              _inputField(
                                "City",
                                cityController,
                                Icons.location_city,
                                validator: (v) =>
                                    v!.isEmpty ? "Required" : null,
                              ),

                              const SizedBox(height: 24),

                              /// SAVE BUTTON
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

  /// INPUT FIELD
  Widget _inputField(
    String label,
    TextEditingController controller,
    IconData icon, {
    bool readOnly = false,
    VoidCallback? onTap,
    TextInputType keyboard = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        keyboardType: keyboard,
        validator: validator,
        decoration: _decoration(label, icon),
      ),
    );
  }

  /// DECORATION
  InputDecoration _decoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      prefixIcon: Icon(icon, color: primaryBlue),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  /// EMAIL VALIDATION
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Required";
    final emailRegex =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return "Invalid email";
    return null;
  }

  /// MOBILE VALIDATION
  String? _validateMobile(String? value) {
    if (value == null || value.isEmpty) return "Required";
    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return "Enter 10-digit mobile number";
    }
    return null;
  }

  /// DATE PICKER
  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2002),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      dobController.text =
          "${picked.day}/${picked.month}/${picked.year}";
    }
  }
}