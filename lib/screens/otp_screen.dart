import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:assihnment_technolitocs/screens/home_screen.dart';
import 'package:assihnment_technolitocs/utils/custom_button.dart';
import 'package:assihnment_technolitocs/utils/custom_text_field.dart';
import 'package:assihnment_technolitocs/utils/ui_colors.dart';
import 'package:assihnment_technolitocs/utils/ui_custom_text.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;
  const OtpScreen({Key? key, required this.mobileNumber}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  int _secondsRemaining = 60;
  Timer? _timer;
  bool _isResendEnabled = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _secondsRemaining = 60;
      _isResendEnabled = false;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 1) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
        setState(() {
          _secondsRemaining = 0;
          _isResendEnabled = true;
        });
      }
    });
  }

  Future<void> _saveLoginCredentials(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('mobile_number', widget.mobileNumber);
    await prefs.setBool('is_logged_in', true);
  }

  Future<void> _resendOtp() async {
    final response = await http.post(
      Uri.parse("https://api.rolbol.org/api/v1/otp/otpMobileNumber"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"mobileNumber": widget.mobileNumber}),
    );

    if (response.statusCode == 200) {
      _startTimer();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("OTP resent successfully.")));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Failed to resend OTP.")));
    }
  }

  Future<void> _handleOtpVerification() async {
    String otp = _controller.text.trim();
    if (otp.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid 4-digit OTP.")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("https://api.rolbol.org/api/v1/otp/verifyotp"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "mobileNumber": int.parse(widget.mobileNumber),
          "otp": otp,
        }),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data["accessToken"] != null) {
        await _saveLoginCredentials(data["accessToken"]);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"] ?? "OTP verification failed."),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An error occurred. Please try again.")),
      );
    } finally {
      setState(() => _isLoading = false);
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
      resizeToAvoidBottomInset: false,
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
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.33,
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(
                paddingHorizontal,
                paddingVertical,
                paddingHorizontal,
                paddingVertical * 1.2,
              ),
              color: UI_COLORS.uiBgColor,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    right: -80,
                    top: -45,
                    child: Container(
                      width: 193,
                      height: 214,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Image.asset('assets/images/bubble.png'),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(height: 24),
                      Text(
                        'VERIFICATION',
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Enter OTP',
                        style: TextStyle(
                          color: UI_COLORS.uiWhiteColor,
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Movatif',
                        ),
                      ),
                      GradientText(
                        text: "Received on your Number",
                        fontSize: 28,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    color: UI_COLORS.uiWhiteColor,
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
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              const Text(
                                "Didn't receive the code?",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff8B8B8B),
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: _isResendEnabled ? _resendOtp : null,
                                child: Text(
                                  "Resend OTP",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color:
                                        _isResendEnabled
                                            ? const Color(0xff2DC0E4)
                                            : Colors.grey,
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            _isResendEnabled
                                ? "You can now request a new OTP."
                                : "Resend available in $_secondsRemaining seconds",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 160,
                          child: CustomButton(
                            onPressed:
                                !_isLoading ? _handleOtpVerification : null,
                            text: _isLoading ? "Verifying..." : "Verify OTP",
                            Function: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -29,
                    left: paddingHorizontal,
                    right: paddingHorizontal,
                    child: CustomTextField(
                      controller: _controller,
                      hintText: "Enter OTP",
                      keyboardType: TextInputType.number,
                      inputFormatters: [],
                      maxLength: 4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
