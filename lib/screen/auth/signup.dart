import 'package:flutter/material.dart';
import 'package:found1/controller/auth_controller.dart';
import 'package:found1/screen/widgets/glitch.dart';
import 'package:found1/screen/widgets/text_input.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _setpasswordController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 150.0),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GlithEffect(
                child: const Text(
                  "Welcome to Found",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
                ),
              ),
              const SizedBox(height: 25),
              // Profile Picture Selector
              // InkWell(
              //   onTap: () {
              //     AuthController.instance.pickImage();
              //   },
              //   child: GetBuilder<AuthController>(
              //     builder: (controller) => Stack(
              //       children: [
              //         CircleAvatar(
              //           backgroundImage: controller.proimg != null
              //               ? FileImage(controller.proimg!)
              //               : const NetworkImage(
              //                   "https://static.vecteezy.com/system/resources/thumbnails/042/535/195/small_2x/profile-icon-illustration-png.png",
              //                 ) as ImageProvider,
              //           radius: 60,
              //         ),
              //         Positioned(
              //           bottom: 0,
              //           right: 0,
              //           child: Container(
              //             padding: const EdgeInsets.all(5),
              //             decoration: BoxDecoration(
              //               color: Colors.white,
              //               borderRadius: BorderRadius.circular(50),
              //             ),
              //             child: const Icon(
              //               Icons.edit,
              //               size: 20,
              //               color: Colors.black,
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              const SizedBox(height: 25),
              // Email Input Field
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: textinputfields(
                  controller: _emailController,
                  myIcon: Icons.email,
                  mylabeltext: "Email",
                ),
              ),
              const SizedBox(height: 20),
              // Set Password Field
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: textinputfields(
                  controller: _setpasswordController,
                  myIcon: Icons.lock,
                  tohide: true,
                  mylabeltext: 'Set Password',
                ),
              ),
              const SizedBox(height: 25),
              // Confirm Password Field
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: textinputfields(
                  controller: _confirmpasswordController,
                  myIcon: Icons.lock,
                  tohide: true,
                  mylabeltext: 'Confirm Password',
                ),
              ),
              const SizedBox(height: 30),
              // Username Field
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: textinputfields(
                  controller: _userController,
                  myIcon: Icons.person,
                  mylabeltext: "Username",
                ),
              ),
              const SizedBox(height: 30),
              // Sign Up Button
              ElevatedButton(
                onPressed: () {
                  if (_setpasswordController.text !=
                      _confirmpasswordController.text) {
                    Get.snackbar("Error", "Passwords do not match.");
                  } else {
                    AuthController.instance.signup(
                      _userController.text.trim(),
                      _emailController.text.trim(),
                      _setpasswordController.text.trim(),
                      //AuthController.instance.proimg, // Nullable image
                    );
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: const Text("Sign Up"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
