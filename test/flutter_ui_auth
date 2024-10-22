import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_auth/flutter_ui_auth.dart';

void main() {
  testWidgets('LoginScreen displays properly and allows form submission',
      (WidgetTester tester) async {
    // Create a mock function to capture login attempts
    String? email;
    String? password;

    // Build the app and trigger a frame
    await tester.pumpWidget(
      MaterialApp(
        home: LoginScreen(
          title: 'My Login App',
          subtitle: 'Please log in',
          onLogin: (inputEmail, inputPassword) {
            email = inputEmail;
            password = inputPassword;
          },
        ),
      ),
    );

    // Verify the screen displays the correct title and subtitle
    expect(find.text('My Login App'), findsOneWidget);
    expect(find.text('Please log in'), findsOneWidget);

    // Verify that the email and password text fields are present
    expect(find.byType(TextField), findsNWidgets(2));

    // Scroll to the button to ensure it's visible
    final Finder signInButton = find.byType(ElevatedButton);
    await tester.ensureVisible(signInButton);

    // Verify that the Sign In button is present and tap it
    expect(signInButton, findsOneWidget);
    await tester.tap(signInButton);
    await tester.pumpAndSettle(); // Wait for the frame to settle

    // Check if validation messages are shown
    expect(find.text('Email is required.'), findsOneWidget);
    expect(find.text('Password is required.'), findsOneWidget);

    // Enter email and password into the form
    await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'password123');

    // Submit the form again
    await tester.tap(signInButton);
    await tester.pumpAndSettle(); // Wait for the frame to settle

    // Verify that the form submission triggered the onLogin callback
    expect(email, 'test@example.com');
    expect(password, 'password123');
  });

  testWidgets('LoginScreen switches between sign-in and sign-up mode',
      (WidgetTester tester) async {
    // Create a mock function to capture login attempts
    String? email;
    String? password;

    // Build the app with LoginScreen
    await tester.pumpWidget(
      MaterialApp(
        home: LoginScreen(
          title: 'My Login App',
          subtitle: 'Please log in',
          onLogin: (inputEmail, inputPassword) {
            email = inputEmail;
            password = inputPassword;
          },
        ),
      ),
    );

    // Verify that the screen starts in sign-in mode
    expect(find.text("Don't have an account? Sign Up"), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
    expect(
        find.byType(TextField), findsNWidgets(2)); // Email and password fields

    // Switch to sign-up mode
    await tester.tap(find.text("Don't have an account? Sign Up"));
    await tester.pumpAndSettle(); // Wait for the frame to settle

    // Verify that the screen switches to sign-up mode
    expect(find.text('Already have an account? Sign In'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.byType(TextField),
        findsNWidgets(4)); // Name, email, password, and confirm password fields

    // Scroll to the button to ensure it's visible
    final Finder signUpButton = find.byType(ElevatedButton);
    await tester.ensureVisible(signUpButton);

    // Try submitting empty form, and check if the error messages are displayed
    await tester.tap(signUpButton);
    await tester.pumpAndSettle(); // Wait for the frame to settle

    expect(find.text('Email is required.'), findsOneWidget);
    expect(find.text('Password is required.'), findsOneWidget);
    expect(find.text('Name is required.'), findsOneWidget);

    // Enter name, email, password, and confirm password
    await tester.enterText(find.byType(TextField).at(0), 'John Doe');
    await tester.enterText(find.byType(TextField).at(1), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(2), 'password123');
    await tester.enterText(find.byType(TextField).at(3), 'password123');

    // Submit the sign-up form
    await tester.tap(signUpButton);
    await tester.pumpAndSettle(); // Wait for the frame to settle

    // Verify the form submission triggered the onLogin callback
    expect(email, 'test@example.com');
    expect(password, 'password123');
  });
}
