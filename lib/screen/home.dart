import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:found1/screen/found_person.dart'; // Import Found Person Screen
import 'package:found1/screen/report_missing.dart'; // Import Report Missing Screen
import 'package:found1/screen/status.dart'; // Import Status Screen
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the current user ID from Firebase Authentication
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Found App'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.logout), // Sign-out icon
          onPressed: () => _signOut(context), // Call the sign-out function
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Heading
              const Text(
                "Welcome to Found App",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),

              // Found Person Button
              _buildNavigationButton(
                context,
                label: "Found Person",
                onPressed: () => Get.to(() => FoundPersonScreen()),
              ),
              const SizedBox(height: 20),

              // Report Missing Button
              _buildNavigationButton(
                context,
                label: "Report Missing",
                onPressed: () => Get.to(() => ReportMissingPersonScreen()),
              ),
              const SizedBox(height: 20),

              // Status Button - Navigating to StatusPage
              _buildNavigationButton(
                context,
                label: "Check Status",
                onPressed: () =>
                    Get.to(() => statuspage()), // Navigate to StatusPage
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to handle sign-out
  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut(); // Sign out from Firebase
      Get.offAllNamed('/login'); // Navigate to the login page
    } catch (e) {
      print("Error signing out: $e");
      Get.snackbar("Error", "Failed to sign out.");
    }
  }

  // Helper method to build navigation buttons with consistent styling
  ElevatedButton _buildNavigationButton(
    BuildContext context, {
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        textStyle: const TextStyle(fontSize: 16),
      ),
      child: Text(label),
    );
  }
}
