import 'dart:convert';
import 'package:assihnment_technolitocs/screens/otp_screen.dart';
import 'package:assihnment_technolitocs/utils/custom_button.dart';
import 'package:assihnment_technolitocs/utils/custom_text_field.dart';
import 'package:assihnment_technolitocs/utils/ui_colors.dart';
import 'package:assihnment_technolitocs/utils/ui_custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller = TextEditingController();
  DateTime? _lastOtpSentTime;
  bool _isSendingOtp = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<bool> sendOtp(String mobileNumber) async {
    const String url = 'https://api.rolbol.org/api/v1/otp/otpMobileNumber';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'mobileNumber': mobileNumber}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        final error = jsonDecode(response.body);
        print('OTP Send Failed: ${error['message'] ?? 'Unknown error'}');
        _showSnackBar(error['message'] ?? 'Failed to send OTP');
        return false;
      }
    } catch (e) {
      print('Exception while sending OTP: $e');
      _showSnackBar("Failed to send OTP. Please try again.");
      return false;
    }
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _onProceedPressed() async {
    if (_isSendingOtp) return;

    String mobile = _controller.text.trim();

    if (mobile.length != 10) {
      _showSnackBar("Please enter a valid 10-digit mobile number.");
      return;
    }

    final now = DateTime.now();
    if (_lastOtpSentTime != null) {
      final difference = now.difference(_lastOtpSentTime!);
      if (difference.inSeconds < 60) {
        final secondsLeft = 60 - difference.inSeconds;
        _showSnackBar(
          "Please wait $secondsLeft seconds before requesting another OTP.",
        );
        return;
      }
    }

    setState(() => _isSendingOtp = true);

    bool otpSent = await sendOtp(mobile);

    if (otpSent) {
      _lastOtpSentTime = DateTime.now();
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpScreen(mobileNumber: mobile),
        ),
      ).then((_) {
        if (mounted) setState(() => _isSendingOtp = false);
      });
    } else {
      if (mounted) setState(() => _isSendingOtp = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double paddingHorizontal = screenWidth * 0.06;
    double paddingVertical = screenHeight * 0.05;
    double topPadding = screenHeight * 0.06;

    return Scaffold(
      backgroundColor: UI_COLORS.uiBgColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: UI_COLORS.uiBgColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15, top: 15),
          child: IconButton(
            icon: Image.asset(
              'assets/images/backward_arrow.png',
              width: 50,
              height: 50,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Top section (blue background)
                Container(
                  height: screenHeight * 0.33,
                  width: double.infinity,
                  color: UI_COLORS.uiBgColor,
                  padding: EdgeInsets.fromLTRB(
                    paddingHorizontal,
                    paddingVertical,
                    paddingHorizontal,
                    paddingVertical * 1.2,
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        right: -80,
                        top: -45,
                        child: Container(
                          width: 193,
                          height: 214,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset('assets/images/bubble.png'),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          const Text(
                            'HEY MEMBER',
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Tell Us Your',
                            style: TextStyle(
                              color: UI_COLORS.uiWhiteColor,
                              fontSize: 28,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Movatif',
                            ),
                          ),
                          GradientText(text: "Mobile Number", fontSize: 28),
                        ],
                      ),
                    ],
                  ),
                ),
                // Bottom section (white background)
                Expanded(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        color: Colors.white,
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(
                          paddingHorizontal,
                          topPadding,
                          paddingHorizontal,
                          paddingVertical,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: const TextSpan(
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xffBABABA),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  children: [
                                    TextSpan(text: "We'll send a "),
                                    TextSpan(
                                      text: 'verification code',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          ' to your mobile number. Enter the code on the next page to login.',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Phone number input field
                      Positioned(
                        top: -29,
                        left: paddingHorizontal,
                        right: paddingHorizontal,
                        child: CustomTextField(
                          controller: _controller,
                          hintText: "Enter your mobile number",
                          prefix: "+91",
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Fixed "Proceed" button (does NOT move with keyboard)
            Positioned(
              left: 0,
              right: 158,
              bottom: 10, // Fixed position
              child: Center(
                child: SizedBox(
                  width: 150,
                  child: CustomButton(
                    onPressed: _isSendingOtp ? null : _onProceedPressed,
                    text: _isSendingOtp ? "Sending..." : "Proceed",
                    Function: () {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
