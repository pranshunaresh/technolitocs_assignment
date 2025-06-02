import 'package:assihnment_technolitocs/Screens/walkthrough_screen.dart';
import 'package:assihnment_technolitocs/config/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:assihnment_technolitocs/screens/home_screen.dart';
import 'package:assihnment_technolitocs/screens/otp_screen.dart';

class AuthChecker extends StatelessWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: AuthService.isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData && snapshot.data == true) {
          return const HomeScreen();
        } else {
          // Replace with your login screen or phone number entry screen
          return const WalthroughScreen(); // Example number
        }
      },
    );
  }
}
