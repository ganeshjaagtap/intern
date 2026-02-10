import 'package:flutter/material.dart';
import '../../../models/student_draft.dart';

class SetLoginCredentialsScreen extends StatefulWidget {
  const SetLoginCredentialsScreen({super.key});

  @override
  State<SetLoginCredentialsScreen> createState() =>
      _SetLoginCredentialsScreenState();
}

class _SetLoginCredentialsScreenState
    extends State<SetLoginCredentialsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final _formKey = GlobalKey<FormState>();
  final Color primaryBlue = const Color(0xFF1976D2);

  final TextEditingController usernameController =
      TextEditingController(text: StudentDraft.username);
  final TextEditingController passwordController =
      TextEditingController(text: StudentDraft.password);
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirm = true;
  bool acceptTerms = false;

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
                      const SizedBox(height: 60),

                      Icon(Icons.lock_outline,
                          size: 70, color: primaryBlue),
                      const SizedBox(height: 10),
                      Text(
                        "Set Login Credentials",
                        style: TextStyle(
                          fontSize: 26,
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
                                "Username / Email",
                                usernameController,
                                Icons.person,
                                validator: _validateUsername,
                              ),
                              _inputField(
                                "Password",
                                passwordController,
                                Icons.lock,
                                obscure: obscurePassword,
                                toggle: () =>
                                    setState(() => obscurePassword = !obscurePassword),
                                validator: _validatePassword,
                              ),
                              _inputField(
                                "Confirm Password",
                                confirmPasswordController,
                                Icons.lock_outline,
                                obscure: obscureConfirm,
                                toggle: () =>
                                    setState(() => obscureConfirm = !obscureConfirm),
                                validator: _validateConfirmPassword,
                              ),

                              CheckboxListTile(
                                value: acceptTerms,
                                onChanged: (v) =>
                                    setState(() => acceptTerms = v!),
                                title: const Text(
                                    "I agree to the Terms & Conditions"),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                contentPadding: EdgeInsets.zero,
                              ),

                              const SizedBox(height: 20),

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed:
                                      acceptTerms ? _saveAndContinue : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryBlue,
                                    disabledBackgroundColor:
                                        Colors.grey.shade400,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    "Create Account",
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
    bool obscure = false,
    VoidCallback? toggle,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(icon, color: primaryBlue),
          suffixIcon: toggle != null
              ? IconButton(
                  icon: Icon(
                    obscure
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: primaryBlue,
                  ),
                  onPressed: toggle,
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  /// VALIDATIONS
  String? _validateUsername(String? v) {
    if (v == null || v.isEmpty) return "Required";
    if (v.contains(" ")) return "No spaces allowed";
    if (v.length < 5) return "Minimum 5 characters";
    return null;
  }

  String? _validatePassword(String? v) {
    if (v == null || v.isEmpty) return "Required";
    if (v.length < 8) return "Minimum 8 characters";
    if (!RegExp(r'[A-Z]').hasMatch(v)) return "Add 1 uppercase letter";
    if (!RegExp(r'[0-9]').hasMatch(v)) return "Add 1 number";
    if (!RegExp(r'[!@#\$&*~]').hasMatch(v)) {
      return "Add 1 special character";
    }
    return null;
  }

  String? _validateConfirmPassword(String? v) {
    if (v == null || v.isEmpty) return "Required";
    if (v != passwordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  /// SAVE INTO DRAFT (FINAL STEP BEFORE BACKEND)
  void _saveAndContinue() {
    if (_formKey.currentState!.validate()) {
      StudentDraft.username = usernameController.text.trim();
      StudentDraft.password = passwordController.text.trim();

      // TEMP success (backend comes next)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Draft saved. Ready for backend.")),
      );

      Navigator.popUntil(context, (route) => route.isFirst);
    }
  }
}
