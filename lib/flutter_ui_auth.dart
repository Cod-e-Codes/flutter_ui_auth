import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class LoginScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final Function(String, String)? onLogin;

  const LoginScreen({
    super.key,
    this.title = 'My Login App',
    this.subtitle = 'Welcome to the app',
    this.onLogin,
  });

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool isSignUp = false;
  late AnimationController _controller;

  // Form controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();

  // Validation flags
  bool showEmailError = false;
  bool showPasswordError = false;
  bool showNameError = false;
  bool showConfirmPasswordError = false;

  // Password visibility toggles
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void toggleSignUpMode() {
    setState(() {
      isSignUp = !isSignUp;
    });
    if (isSignUp) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void validateAndLogin() {
    setState(() {
      showEmailError = emailController.text.isEmpty;
      showPasswordError = passwordController.text.isEmpty;
      if (isSignUp) {
        showNameError = nameController.text.isEmpty;
        showConfirmPasswordError =
            confirmPasswordController.text != passwordController.text;
      }
    });

    if (!showEmailError &&
        !showPasswordError &&
        (!isSignUp || !showNameError)) {
      widget.onLogin!(emailController.text, passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: AnimationLimiter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 375),
                childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: [
                  Text(
                    widget.title,
                    style: GoogleFonts.montserrat(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.subtitle,
                    style: GoogleFonts.roboto(fontSize: 16),
                  ),
                  const SizedBox(height: 20),

                  // Name field (only for Sign Up mode)
                  if (isSignUp)
                    _buildTextField(
                      controller: nameController,
                      label: 'Name',
                      errorVisible: showNameError,
                      errorMessage: 'Name is required.',
                    ),

                  // Email field
                  _buildTextField(
                    controller: emailController,
                    label: 'Email',
                    errorVisible: showEmailError,
                    errorMessage: 'Email is required.',
                  ),
                  const SizedBox(height: 10),

                  // Password field with visibility toggle
                  _buildTextField(
                    controller: passwordController,
                    label: 'Password',
                    obscureText: !isPasswordVisible,
                    trailingIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                    errorVisible: showPasswordError,
                    errorMessage: 'Password is required.',
                  ),
                  const SizedBox(height: 10),

                  // Confirm Password field (only for Sign Up mode)
                  if (isSignUp)
                    _buildTextField(
                      controller: confirmPasswordController,
                      label: 'Confirm Password',
                      obscureText: !isConfirmPasswordVisible,
                      trailingIcon: IconButton(
                        icon: Icon(
                          isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isConfirmPasswordVisible =
                                !isConfirmPasswordVisible;
                          });
                        },
                      ),
                      errorVisible: showConfirmPasswordError,
                      errorMessage: 'Passwords do not match.',
                    ),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: validateAndLogin,
                    child: Text(isSignUp ? 'Sign Up' : 'Sign In'),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: toggleSignUpMode,
                    child: Text(
                      isSignUp
                          ? 'Already have an account? Sign In'
                          : "Don't have an account? Sign Up",
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
    Widget? trailingIcon,
    required bool errorVisible,
    required String errorMessage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            suffixIcon: trailingIcon,
          ),
        ),
        if (errorVisible)
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
