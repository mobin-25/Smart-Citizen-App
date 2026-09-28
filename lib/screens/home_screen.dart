import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'my_complaints_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // =========================
  // CONTROLLERS
  // =========================

  final TextEditingController complaintController =
      TextEditingController();

  final ImagePicker picker = ImagePicker();

  // =========================
  // VARIABLES
  // =========================

  XFile? selectedImage;

  String? selectedCategory;

  // =========================
  // COMPLAINT CATEGORIES
  // =========================

  final List<String> categories = [
    'Road / Pothole',
    'Garbage',
    'Streetlight',
    'Water Supply',
    'Drainage',
    'Other',
  ];

  // =========================
  // OPEN CAMERA
  // =========================

  Future<void> openCamera() async {
    try {
      final XFile? image = await picker.pickImage(
        source: ImageSource.camera,
      );

      if (!mounted) return;

      if (image != null) {
        setState(() {
          selectedImage = image;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Photo captured successfully!',
            ),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Unable to open camera.',
          ),
        ),
      );
    }
  }

  // =========================
  // SUBMIT COMPLAINT
  // =========================

  void submitComplaint() {
    if (selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select a complaint category.',
          ),
        ),
      );
      return;
    }

    if (complaintController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter your complaint.',
          ),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Complaint submitted under $selectedCategory!',
        ),
      ),
    );

    // Clear form after submission
    setState(() {
      selectedCategory = null;
      selectedImage = null;
    });

    complaintController.clear();
  }

  // =========================
  // NAVIGATION
  // =========================

  void handleBottomNavigation(int index) {
    if (index == 0) {
      // Already on Home
      return;
    }

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const MyComplaintsScreen(),
        ),
      );
    }

    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const ProfileScreen(),
        ),
      );
    }
  }

  // =========================
  // DISPOSE
  // =========================

  @override
  void dispose() {
    complaintController.dispose();
    super.dispose();
  }

  // =========================
  // BUILD
  // =========================

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // =========================
      // APP BAR
      // =========================

      appBar: AppBar(
        title: const Text(
          'Smart Citizen',
        ),
        centerTitle: true,
      ),

      // =========================
      // BODY
      // =========================

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch,

          children: [

            const SizedBox(height: 10),

            // =========================
            // APP LOGO
            // =========================

            Image.asset(
              'assets/images/logo.png',
              height: 220,
              width: 220,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 10),

            // =========================
            // APP NAME
            // =========================

            const Text(
              'Smart Citizen App',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            // =========================
            // APP DESCRIPTION
            // =========================

            const Text(
              'Report civic issues quickly and easily',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 35),

            // =========================
            // RAISE COMPLAINT
            // =========================

            const Text(
              'Raise a Complaint',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            // =========================
            // CATEGORY
            // =========================

            const Text(
              'Complaint Category',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              initialValue: selectedCategory,

              decoration: const InputDecoration(
                labelText: 'Select Category',
                prefixIcon: Icon(
                  Icons.category,
                ),
                border: OutlineInputBorder(),
              ),

              items: categories.map(
                (String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                },
              ).toList(),

              onChanged: (String? value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),

            const SizedBox(height: 20),

            // =========================
            // DESCRIPTION
            // =========================

            const Text(
              'Complaint Description',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: complaintController,
              maxLines: 5,

              decoration: const InputDecoration(
                hintText:
                    'Describe your complaint...',
                prefixIcon: Icon(
                  Icons.report_problem,
                ),
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),

            const SizedBox(height: 20),

            // =========================
            // ADD PHOTO
            // =========================

            const Text(
              'Add Photo',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            GestureDetector(
              onTap: openCamera,

              child: Container(
                height: 150,

                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                  borderRadius:
                      BorderRadius.circular(12),
                ),

                child: selectedImage == null
                    ? const Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [

                          Icon(
                            Icons.camera_alt,
                            size: 55,
                            color: Colors.blue,
                          ),

                          SizedBox(height: 8),

                          Text(
                            'Tap to open camera',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )
                    : ClipRRect(
                        borderRadius:
                            BorderRadius.circular(10),

                        child: kIsWeb
                            ? Image.network(
                                selectedImage!.path,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(
                                  selectedImage!.path,
                                ),
                                fit: BoxFit.cover,
                              ),
                      ),
              ),
            ),

            const SizedBox(height: 25),

            // =========================
            // SUBMIT BUTTON
            // =========================

            ElevatedButton.icon(
              onPressed: submitComplaint,

              icon: const Icon(
                Icons.send,
              ),

              label: const Text(
                'Submit Complaint',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),

              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(
                  vertical: 15,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),

      // =========================
      // BOTTOM NAVIGATION
      // =========================

      bottomNavigationBar:
          BottomNavigationBar(
        currentIndex: 0,

        onTap: handleBottomNavigation,

        items: const [

          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.list_alt,
            ),
            label: 'Complaints',
          ),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
 