import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      // =========================
      // APP BAR
      // =========================

      appBar: AppBar(
        title: const Text(
          'Help & Support',
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // =========================
            // HEADER
            // =========================

            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade600,
                    Colors.blue.shade400,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [

                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(
                        alpha: 0.2,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.support_agent,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'How can we help?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Find answers or contact our support team.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // =========================
            // FAQ
            // =========================

            const Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            _buildFAQ(
              question: 'How do I raise a complaint?',
              answer:
                  'Go to the Home page, select a complaint category, describe the issue, add a photo if required, and tap Submit Complaint.',
            ),

            _buildFAQ(
              question: 'How can I track my complaint?',
              answer:
                  'Open My Complaints from the bottom navigation or your Profile. Select a complaint to view its current status.',
            ),

            _buildFAQ(
              question: 'What do the complaint statuses mean?',
              answer:
                  'Submitted means your complaint has been received. Processed means it has been reviewed and assigned. In Progress means the concerned department is working on it. Resolved means the issue has been addressed.',
            ),

            _buildFAQ(
              question: 'Can I edit my profile?',
              answer:
                  'Yes. Open Profile and tap Edit Profile to update your name, mobile number, email, or Aadhaar ID.',
            ),

            const SizedBox(height: 28),

            // =========================
            // CONTACT SUPPORT
            // =========================

            const Text(
              'Contact Support',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [

                  _buildContactTile(
                    icon: Icons.email_outlined,
                    title: 'Email Support',
                    subtitle: 'support@smartcitizen.com',
                    onTap: () {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Email support selected.',
                          ),
                        ),
                      );
                    },
                  ),

                  const Divider(height: 1),

                  _buildContactTile(
                    icon: Icons.phone_outlined,
                    title: 'Call Support',
                    subtitle: '+91 XXXXX XXXXX',
                    onTap: () {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Call support selected.',
                          ),
                        ),
                      );
                    },
                  ),

                  const Divider(height: 1),

                  _buildContactTile(
                    icon: Icons.chat_outlined,
                    title: 'Chat with Support',
                    subtitle: 'Get help from our support team',
                    onTap: () {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Chat support coming soon.',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // =========================
            // APP INFORMATION
            // =========================

            Center(
              child: Text(
                'Smart Citizen App\nVersion 1.0.0',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // =========================
  // FAQ WIDGET
  // =========================

  Widget _buildFAQ({
    required String question,
    required String answer,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ExpansionTile(
        leading: Icon(
          Icons.help_outline,
          color: Colors.blue.shade600,
        ),
        title: Text(
          question,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(
          20,
          0,
          20,
          16,
        ),
        children: [
          Text(
            answer,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // CONTACT TILE
  // =========================

  Widget _buildContactTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
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
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
      ),
      onTap: onTap,
    );
  }
}