import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:found1/screen/widgets/glitch.dart';
import 'package:found1/screen/widgets/text_input.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ReportMissingPersonScreen extends StatefulWidget {
  @override
  _ReportMissingPersonScreenState createState() =>
      _ReportMissingPersonScreenState();
}

class _ReportMissingPersonScreenState extends State<ReportMissingPersonScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController =
      TextEditingController(); // New description field
  File? _image; // To store the picked image
  final ImagePicker picker = ImagePicker(); // Image picker instance

  // Function to pick an image from the gallery or camera
  Future<void> _pickImage() async {
    final selectedSource = await showDialog<ImageSource>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Select Image Source"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(ImageSource.camera);
              },
              child: const Text("Camera"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(ImageSource.gallery);
              },
              child: const Text("Gallery"),
            ),
          ],
        );
      },
    );

    if (selectedSource != null) {
      final pickedFile = await picker.pickImage(source: selectedSource);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    }
  }

  // Function to upload the image to Firebase Storage
  Future<String?> _uploadImage() async {
    if (_image == null) return null;

    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('missing_persons_images/$fileName');
      UploadTask uploadTask = storageRef.putFile(_image!);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error uploading image: $e");
      Get.snackbar("Error", "Failed to upload image.");
      return null;
    }
  }

  // Function to save the missing person data to Firestore
  Future<void> _saveMissingPerson() async {
    if (_nameController.text.isEmpty ||
        _ageController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _descriptionController
            .text.isEmpty || // Ensure description is not empty
        _image == null) {
      Get.snackbar("Error", "All fields are required.");
      return;
    }

    try {
      String? imageUrl = await _uploadImage();
      if (imageUrl == null) {
        Get.snackbar("Error", "Failed to upload image.");
        return;
      }

      await FirebaseFirestore.instance.collection('missing_persons').add({
        'name': _nameController.text,
        'age': _ageController.text,
        'phone': _phoneController.text,
        'location': _locationController.text,
        'description':
            _descriptionController.text, // Save description to Firestore
        'image_url': imageUrl,
        'status': 0, // Default status as 0 (pending)
        'timestamp': FieldValue.serverTimestamp(),
      });

      Get.snackbar("Success", "Missing person reported successfully!");

      // Clear all fields after successful submission
      _clearForm();
    } catch (e) {
      print("Error saving data: $e");
      Get.snackbar("Error", "Failed to report missing person.");
    }
  }

  // Function to clear the form fields and image
  void _clearForm() {
    _nameController.clear();
    _ageController.clear();
    _phoneController.clear();
    _locationController.clear();
    _descriptionController.clear(); // Clear the description field
    setState(() {
      _image = null; // Reset the image
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Missing Person'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title with glitch effect
              GlithEffect(
                child: const Text(
                  "Missing Person Report",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
                ),
              ),
              const SizedBox(height: 20),

              // Name input field
              textinputfields(
                controller: _nameController,
                myIcon: Icons.person,
                mylabeltext: "Name",
              ),
              const SizedBox(height: 15),

              // Age input field
              textinputfields(
                controller: _ageController,
                myIcon: Icons.calendar_today,
                mylabeltext: "Age",
              ),
              const SizedBox(height: 15),

              // Phone Number input field
              textinputfields(
                controller: _phoneController,
                myIcon: Icons.phone,
                mylabeltext: "Phone Number",
              ),
              const SizedBox(height: 15),

              // Location input field
              textinputfields(
                controller: _locationController,
                myIcon: Icons.location_on,
                mylabeltext: "Location",
              ),
              const SizedBox(height: 15),

              // Description input field
              textinputfields(
                controller: _descriptionController,
                myIcon: Icons.description,
                mylabeltext: "Description",
              ),
              const SizedBox(height: 30),

              // Image Picker
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _image == null
                      ? const Icon(
                          Icons.camera_alt,
                          size: 50,
                          color: Colors.white,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            _image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: _saveMissingPerson,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  child: const Text("Submit Report"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
