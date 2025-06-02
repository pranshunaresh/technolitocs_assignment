import 'dart:async';
import 'package:assihnment_technolitocs/Screens/login_screen.dart';
import 'package:assihnment_technolitocs/utils/ui_colors.dart';
import 'package:assihnment_technolitocs/utils/ui_custom_text.dart';
import 'package:flutter/material.dart';

class WalthroughScreen extends StatefulWidget {
  const WalthroughScreen({Key? key}) : super(key: key);

  @override
  State<WalthroughScreen> createState() => _WalthroughScreenState();
}

class _WalthroughScreenState extends State<WalthroughScreen> {
  final List<String> imageAssets = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
    'assets/images/5.jpg',
  ];

  final List<Map<String, String>> headingTexts = [
    {'normal': 'Making Rest of Life,\n', 'highlight': 'Best of Life.'},
    {'normal': '', 'highlight': 'Social\n'},
    {'normal': '', 'highlight': 'Learning\n'},
    {'normal': '', 'highlight': 'Lifestyle\n'},
    {'normal': '', 'highlight': 'Connect\n'},
  ];

  int currentIndex = 0;
  late final PageController _pageController;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (currentIndex < imageAssets.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }
      _pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildIndicator(int index) {
    bool isActive = index == currentIndex;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery for Responsive Design
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: UI_COLORS.uiBgColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/bg.png', fit: BoxFit.cover),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.06,
              ), // Around 24px on 400px screen
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 18),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      screenWidth * 0.75,
                    ), // Responsive radius
                    child: SizedBox(
                      width: screenWidth * 0.64,
                      height: screenHeight * 0.52,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: imageAssets.length,
                        onPageChanged: (index) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Image.asset(
                            imageAssets[index],
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Dynamic Heading Text
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontFamily: 'Movatif',
                      ),
                      children: [
                        TextSpan(text: headingTexts[currentIndex]['normal']),
                        WidgetSpan(
                          child: GradientText(
                            text: headingTexts[currentIndex]['highlight']!,
                            fontSize: 32,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      imageAssets.length,
                      (index) => _buildIndicator(index),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'New to Our Community ?',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xffBABABA),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: UI_COLORS.uiWhiteColor,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                            child: const Text(
                              'Continue as Guest',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff252424),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                            child: const Text(
                              'Already a Member ? Login',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
