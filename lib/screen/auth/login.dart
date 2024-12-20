import 'package:flutter/material.dart';
import 'package:found1/controller/auth_controller.dart';
import 'package:found1/screen/auth/signup.dart';
import 'package:found1/screen/widgets/glitch.dart';
import 'package:found1/screen/widgets/text_input.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Glitch Effect for the app name
            GlithEffect(
              child: const Text(
                "Found",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
              ),
            ),
            const SizedBox(height: 25),

            // Email input field
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: textinputfields(
                controller: _emailController,
                myIcon: Icons.email,
                mylabeltext: "Email",
              ),
            ),
            const SizedBox(height: 20),

            // Password input field
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: textinputfields(
                controller: _passwordController,
                myIcon: Icons.lock,
                tohide: true,
                mylabeltext: 'Password',
              ),
            ),
            const SizedBox(height: 30),

            // Login button
            ElevatedButton(
              onPressed: () {
                // Calling login method from AuthController
                AuthController.instance
                    .login(_emailController.text, _passwordController.text);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: const Text("Login"),
              ),
            ),

            const SizedBox(height: 20),

            // Sign Up button (Navigating to SignUpScreen)
            ElevatedButton(
              onPressed: () {
                // Navigate to the SignUpScreen when clicked
                Get.to(() => SignupScreen());
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                child: const Text("Sign Up"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
