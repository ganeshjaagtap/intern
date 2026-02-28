import 'package:flutter/material.dart';
import '../auth/Main_Login.dart'; // Ensure this matches your login file
import 'EditProfileScreen.dart';
import 'NotificationScreen.dart';
import 'PrivacySecurityScreen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    // ✅ REMOVED: Scaffold and AppBar (handled by the parent StudentMainLayout)
    // ✅ RETURNING: Only the Body content
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 👤 PROFILE CARD
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.redAccent,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Alex Johnson",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        "alex_johnson@university.edu",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Student",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.grey),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                    );
                  },
                )
              ],
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            "Settings",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          const SizedBox(height: 12),

          /// 🛠️ SETTINGS LIST
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                SettingsTile(
                  icon: Icons.person_outline,
                  title: "Edit Profile",
                  subtitle: "Update your personal information",
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen())),
                ),
                const Divider(height: 1, indent: 50),
                SettingsTile(
                  icon: Icons.notifications_none,
                  title: "Notifications",
                  subtitle: "Manage push notifications",
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationScreen())),
                ),
                const Divider(height: 1, indent: 50),
                SettingsTile(
                  icon: Icons.lock_outline,
                  title: "Privacy & Security",
                  subtitle: "Password and security settings",
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacySecurityScreen())),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// 🌙 DARK MODE TOGGLE
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(Icons.dark_mode, color: Colors.blue),
                const SizedBox(width: 12),
                const Expanded(child: Text("Dark Mode")),
                Switch(
                  value: isDarkMode,
                  activeColor: Colors.blue,
                  onChanged: (v) {
                    setState(() => isDarkMode = v);
                  },
                )
              ],
            ),
          ),

          const SizedBox(height: 30),

          /// 🚪 LOG OUT
          OutlinedButton.icon(
            onPressed: () {
              // Redirects to Main Login and clears the stack
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout, color: Colors.red),
            label: const Text(
              "Log Out",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.red),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

/// ✅ REUSABLE SETTINGS TILE
class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.blue, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}