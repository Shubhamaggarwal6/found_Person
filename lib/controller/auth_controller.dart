import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:found1/model/user.dart';
import 'package:found1/screen/auth/login.dart';
import 'package:found1/screen/home.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user, _setInitialView);
  }

  // Navigate to the appropriate screen based on authentication state
  _setInitialView(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen()); // If no user, navigate to login screen
    } else {
      Get.offAll(
          () => HomePage()); // If user is authenticated, navigate to HomePage
    }
  }

  // Sign Up User
  void signup(String username, String email, String password) async {
    try {
      if (username.isEmpty || email.isEmpty || password.isEmpty) {
        Get.snackbar("Error", "All fields are required.");
        return;
      }

      // Create user with email and password
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Create a user object (myUser model)
      myUser user = myUser(
        name: username,
        email: email,
        uid: credential.user!.uid,
      );

      // Save user to Firestore
      await FirebaseFirestore.instance
          .collection('users') // Save user in Firestore
          .doc(credential.user!.uid)
          .set(user.toJson());

      Get.snackbar("Success", "Account created successfully!");
    } catch (e) {
      print("Error during signup: $e");
      Get.snackbar("Signup Error", e.toString());
    }
  }

  // Login User
  void login(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        // Attempt to sign in
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        Get.snackbar("Success", "Logged in successfully!");
        Get.offAll(() =>
            HomePage()); // Redirect to the HomePage after successful login
      } else {
        Get.snackbar("Error", "Please enter both email and password.");
      }
    } catch (e) {
      Get.snackbar("Login Error", e.toString());
    }
  }

  // Logout User
}
