# flutter_ui_auth

A customizable login and sign-up screen with beautiful animations for Flutter applications. This package provides an easy way to add a responsive and animated authentication UI to your Flutter app.

## Features

- Customizable login and sign-up forms.
- Beautiful staggered animations for loading and form transitions.
- Responsive design that works on different screen sizes.
- Customizable text fields and validation logic.
- Supports toggling between sign-in and sign-up modes.
- Password visibility toggles.

## Getting started

To use this package, add `flutter_ui_auth` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_ui_auth: ^1.0.0
```

Then, run the following command:

```bash
flutter pub get
```

## Usage

### Basic Example

Here’s a simple example of how to use the `LoginScreen` widget in your app:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_ui_auth/flutter_ui_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(
        title: 'Welcome to MyApp',
        subtitle: 'Login to continue',
        onLogin: (email, password) {
          // Handle login logic here
        },
      ),
    );
  }
}
```

### Customization

You can customize the look and feel of the login screen by passing different parameters to the `LoginScreen` widget:

```dart
LoginScreen(
  title: 'My Custom App',
  subtitle: 'Sign in or register below',
  onLogin: (email, password) {
    // Your authentication logic here
  },
  // Add other customization options
)
```

### Available Widgets

- `LoginScreen`: The main screen widget that provides a sign-in and sign-up form with animated transitions.
- Password visibility toggles and validation are included by default.

## Additional information

This package is actively maintained. If you encounter any issues or have feature requests, feel free to open an issue on [GitHub](https://github.com/cod-e-codes/flutter_ui_auth).

### Contributing

Contributions are welcome! If you'd like to contribute, please submit a pull request or file an issue on the repository.

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
