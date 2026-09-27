import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController complaintController =
      TextEditingController();

  final ImagePicker picker = ImagePicker();

  XFile? selectedImage;

  // Selected complaint category
  String? selectedCategory;

  // Complaint categories
  final List<String> categories = [
    'Road / Pothole',
    'Garbage',
    'Streetlight',
    'Water Supply',
    'Drainage',
    'Other',
  ];

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
            content: Text('Photo captured successfully!'),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to open camera.'),
        ),
      );
    }
  }

  void submitComplaint() {
    if (selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a complaint category.'),
        ),
      );
      return;
    }

    if (complaintController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your complaint.'),
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
  }

  @override
  void dispose() {
    complaintController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Citizen'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            // App Logo
            const Icon(
              Icons.location_city,
              size: 90,
              color: Colors.blue,
            ),

            const SizedBox(height: 10),

            const Text(
              'Smart Citizen App',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Report civic issues quickly and easily',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 35),

            // Raise Complaint
            const Text(
              'Raise a Complaint',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            // Category Selection
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
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(),
              ),
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),

            const SizedBox(height: 20),

            // Complaint Description
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
                hintText: 'Describe your complaint...',
                prefixIcon: Icon(Icons.report_problem),
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),

            const SizedBox(height: 20),

            // Camera section
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
                  borderRadius: BorderRadius.circular(12),
                ),
                child: selectedImage == null
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                        borderRadius: BorderRadius.circular(10),
                        child: kIsWeb
                            ? Image.network(
                                selectedImage!.path,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(selectedImage!.path),
                                fit: BoxFit.cover,
                              ),
                      ),
              ),
            ),

            const SizedBox(height: 25),

            // Submit button
            ElevatedButton.icon(
              onPressed: submitComplaint,
              icon: const Icon(Icons.send),
              label: const Text(
                'Submit Complaint',
                style: TextStyle(fontSize: 17),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}