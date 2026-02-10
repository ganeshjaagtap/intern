import 'package:flutter/material.dart';
import 'ChangePasswordScreen.dart';

class PrivacySecurityScreen extends StatefulWidget {
  const PrivacySecurityScreen({super.key});

  @override
  State<PrivacySecurityScreen> createState() => _PrivacySecurityScreenState();
}

class _PrivacySecurityScreenState extends State<PrivacySecurityScreen> {
  bool twoFactorEnabled = false;
  bool biometricEnabled = false;
  bool activityAlerts = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),

      /// APP BAR
      appBar: AppBar(
        backgroundColor: const Color(0xFF6BB6FF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "PRIVACY & SECURITY",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      /// BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// SECURITY
            const Text(
              "Security",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),

            _card(
              children: [
                _tile(
                  icon: Icons.lock_outline,
                  title: "Change Password",
                  subtitle: "Update your account password",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ChangePasswordScreen(),
                      ),
                    );
                  },
                ),
                _divider(),
                _switchTile(
                  icon: Icons.verified_user,
                  title: "Two-Factor Authentication",
                  subtitle: "Extra security for your account",
                  value: twoFactorEnabled,
                  onChanged: (v) {
                    setState(() => twoFactorEnabled = v);
                  },
                ),
                _divider(),
                _switchTile(
                  icon: Icons.fingerprint,
                  title: "Biometric Login",
                  subtitle: "Use fingerprint or face ID",
                  value: biometricEnabled,
                  onChanged: (v) {
                    setState(() => biometricEnabled = v);
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// PRIVACY
            const Text(
              "Privacy",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),

            _card(
              children: [
                _switchTile(
                  icon: Icons.visibility_off,
                  title: "Hide Profile Information",
                  subtitle: "Limit visibility to mentors only",
                  value: true,
                  onChanged: (_) {},
                ),
                _divider(),
                _switchTile(
                  icon: Icons.security,
                  title: "Login Activity Alerts",
                  subtitle: "Get alerts for new logins",
                  value: activityAlerts,
                  onChanged: (v) {
                    setState(() => activityAlerts = v);
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// LOG OUT ALL DEVICES
            _card(
              children: [
                _tile(
                  icon: Icons.logout,
                  title: "Log Out from All Devices",
                  subtitle: "Force logout everywhere",
                  textColor: Colors.red,
                  onTap: () {
                    _confirmLogout(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------- UI HELPERS ----------

  Widget _card({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(children: children),
    );
  }

  Widget _tile({
    required IconData icon,
    required String title,
    required String subtitle,
    Color? textColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? Colors.blue),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _switchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      secondary: Icon(icon, color: Colors.blue),
      title: Text(title, style: const TextStyle(fontSize: 14)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _divider() => const Divider(height: 1);

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Log out everywhere?"),
        content: const Text("This will sign you out from all devices."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Logged out from all devices"),
                ),
              );
            },
            child: const Text(
              "Log Out",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
