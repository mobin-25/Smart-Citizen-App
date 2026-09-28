import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'my_complaints_screen.dart';
import 'notifications_screen.dart';
import 'help_support_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // =========================
  // PROFILE DATA
  // =========================

  String name = 'Nisha Maity';
  String mobile = '+91 XXXXX XXXXX';
  String email = 'nisha@example.com';
  String aadhaar = 'XXXX XXXX 1234';

  // =========================
  // EDIT PROFILE
  // =========================

  void _showEditProfileDialog() {
    final nameController =
        TextEditingController(text: name);

    final mobileController =
        TextEditingController(text: mobile);

    final emailController =
        TextEditingController(text: email);

    final aadhaarController =
        TextEditingController(text: aadhaar);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Edit Profile',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Name
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon:
                        Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 15),

                // Mobile
                TextField(
                  controller: mobileController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Mobile Number',
                    prefixIcon:
                        Icon(Icons.phone_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 15),

                // Email
                TextField(
                  controller: emailController,
                  keyboardType:
                      TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon:
                        Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 15),

                // Aadhaar
                TextField(
                  controller: aadhaarController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Aadhaar ID',
                    prefixIcon:
                        Icon(Icons.badge_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),

          actions: [
            // Cancel
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),

            // Save
            ElevatedButton(
              onPressed: () {
                final newName =
                    nameController.text.trim();

                final newMobile =
                    mobileController.text.trim();

                final newEmail =
                    emailController.text.trim();

                final newAadhaar =
                    aadhaarController.text.trim();

                if (newName.isEmpty ||
                    newMobile.isEmpty ||
                    newEmail.isEmpty ||
                    newAadhaar.isEmpty) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Please fill all profile fields.',
                      ),
                    ),
                  );
                  return;
                }

                setState(() {
                  name = newName;
                  mobile = newMobile;
                  email = newEmail;
                  aadhaar = newAadhaar;
                });

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Profile updated successfully!',
                    ),
                  ),
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // =========================
  // BUILD
  // =========================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      // =========================
      // APP BAR
      // =========================

      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      // =========================
      // BODY
      // =========================

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            // =========================
            // PROFILE HEADER
            // =========================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade600,
                    Colors.blue.shade400,
                  ],
                ),
                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.white,

                    child: Icon(
                      Icons.person,
                      size: 58,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    'Citizen Account',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // =========================
            // EDIT PROFILE
            // =========================

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed:
                    _showEditProfileDialog,

                icon: const Icon(Icons.edit),

                label: const Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                style:
                    ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 14,
                  ),

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // =========================
            // PERSONAL INFORMATION
            // =========================

            _buildSectionTitle(
              'Personal Information',
            ),

            const SizedBox(height: 10),

            Card(
              elevation: 1,
              color: Colors.white,

              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(16),
              ),

              child: Column(
                children: [
                  _buildInfoTile(
                    icon:
                        Icons.person_outline,
                    title: 'Full Name',
                    value: name,
                  ),

                  const Divider(height: 1),

                  _buildInfoTile(
                    icon:
                        Icons.phone_outlined,
                    title: 'Mobile Number',
                    value: mobile,
                  ),

                  const Divider(height: 1),

                  _buildInfoTile(
                    icon:
                        Icons.email_outlined,
                    title: 'Email',
                    value: email,
                  ),

                  const Divider(height: 1),

                  _buildInfoTile(
                    icon:
                        Icons.badge_outlined,
                    title: 'Aadhaar ID',
                    value: aadhaar,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // =========================
            // ACCOUNT
            // =========================

            _buildSectionTitle('Account'),

            const SizedBox(height: 10),

            Card(
              elevation: 1,
              color: Colors.white,

              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(16),
              ),

              child: Column(
                children: [
                  // My Complaints
                  _buildOptionTile(
                    icon: Icons.list_alt,
                    title: 'My Complaints',
                    subtitle:
                        'View and track your complaints',

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const MyComplaintsScreen(),
                        ),
                      );
                    },
                  ),

                  const Divider(height: 1),

                  // Notifications
                  _buildOptionTile(
                    icon:
                        Icons.notifications_outlined,
                    title: 'Notifications',
                    subtitle:
                        'View complaint updates',

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const NotificationsScreen(),
                        ),
                      );
                    },
                  ),

                  const Divider(height: 1),

                  // Help & Support
                  _buildOptionTile(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    subtitle:
                        'FAQs and contact support',

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const HelpSupportScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // =========================
            // LOGOUT
            // =========================

            SizedBox(
              width: double.infinity,

              child: OutlinedButton.icon(
                onPressed: () {
                  _showLogoutDialog(context);
                },

                icon: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),

                label: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                style:
                    OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 14,
                  ),

                  side: const BorderSide(
                    color: Colors.red,
                  ),

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  // =========================
  // SECTION TITLE
  // =========================

  Widget _buildSectionTitle(
    String title,
  ) {
    return Align(
      alignment: Alignment.centerLeft,

      child: Text(
        title,

        style: const TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // =========================
  // INFORMATION TILE
  // =========================

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 4,
      ),

      leading: Container(
        height: 42,
        width: 42,

        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          shape: BoxShape.circle,
        ),

        child: Icon(
          icon,
          color: Colors.blue.shade600,
        ),
      ),

      title: Text(
        title,

        style: const TextStyle(
          fontSize: 13,
          color: Colors.grey,
        ),
      ),

      subtitle: Padding(
        padding:
            const EdgeInsets.only(top: 3),

        child: Text(
          value,

          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // =========================
  // OPTION TILE
  // =========================

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 6,
      ),

      leading: Container(
        height: 45,
        width: 45,

        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          shape: BoxShape.circle,
        ),

        child: Icon(
          icon,
          color: Colors.blue.shade600,
        ),
      ),

      title: Text(
        title,

        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),

      subtitle: Text(
        subtitle,

        style: TextStyle(
          fontSize: 13,
          color: Colors.grey.shade600,
        ),
      ),

      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey,
      ),

      onTap: onTap,
    );
  }

  // =========================
  // LOGOUT DIALOG
  // =========================

  void _showLogoutDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,

      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Logout',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          content: const Text(
            'Are you sure you want to logout?',
          ),

          actions: [
            // Cancel
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },

              child: const Text('Cancel'),
            ),

            // Logout
            ElevatedButton(
              onPressed: () {
                // Close logout dialog
                Navigator.pop(dialogContext);

                // =========================
                // FRONTEND-ONLY LOGOUT
                // =========================
                //
                // Removes Home/Profile/etc.
                // and opens LoginScreen.
                //
                Navigator.pushAndRemoveUntil(
                  context,

                  MaterialPageRoute(
                    builder: (context) =>
                        const LoginScreen(),
                  ),

                  (route) => false,
                );
              },

              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}