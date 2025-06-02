import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:assihnment_technolitocs/screens/explore_page/activity_page/activities_screen.dart';
import 'package:assihnment_technolitocs/screens/profile_screen.dart';
import 'package:assihnment_technolitocs/utils/home/home_all_features_section.dart';
import 'package:assihnment_technolitocs/utils/home/home_explore_section.dart';
import 'package:assihnment_technolitocs/utils/home/home_recent_update_section.dart';
import 'package:assihnment_technolitocs/utils/ui_colors.dart';
import 'package:assihnment_technolitocs/screens/explore_page/directory_screen.dart';
import '../utils/home/home_side_menu.dart';

class HomeScreenModel {
  final List<String> imageUrls;
  HomeScreenModel({required this.imageUrls});

  static Future<HomeScreenModel> fetchFromBackend() async {
    await Future.delayed(const Duration(seconds: 1));
    return HomeScreenModel(
      imageUrls: [
        'assets/images/h1.jpg',
        'assets/images/h2.jpg',
        'assets/images/h3.jpg',
      ],
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenModel? _homeScreenModel;

  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentIndex = 0;
  int _selectedTabIndex = 0;
  int _previousTabIndex = 0;
  Timer? _autoScrollTimer;
  bool _showAppBar = true;

  @override
  void initState() {
    super.initState();
    _loadHomeScreenData();
    _startAutoScroll();
  }

  Future<void> _loadHomeScreenData() async {
    final model = await HomeScreenModel.fetchFromBackend();
    setState(() {
      _homeScreenModel = model;
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients && _homeScreenModel != null) {
        _currentIndex =
            (_currentIndex + 1) % _homeScreenModel!.imageUrls.length;
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _onTabSelected(int index) {
    if (_selectedTabIndex == index) return;

    setState(() {
      _previousTabIndex = _selectedTabIndex;
      _selectedTabIndex = index;
      _showAppBar = index != 3;
    });
  }

  Widget _getBodyContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildHomeContent();
      case 1:
        return const Directory();
      case 2:
        return const ActivityScreen();
      case 3:
        return const ProfileScreen();
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildHomeContent() {
    final Gradient textGradient = const LinearGradient(
      colors: [Color(0xFF30D6EF), Color(0xFF6A81EB), Color(0xFF794CEC)],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        _buildImageScroller(),
        const SizedBox(height: 16),
        const AllFeatureSection(),
        const SizedBox(height: 12),
        const ExploreSection(),
        const SizedBox(height: 12),
        const RecentUpdatesSection(),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Rest of Life',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  fontFamily: 'Movatif',
                ),
              ),
              Text(
                'Best of Life',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Movatif',
                  foreground:
                      Paint()
                        ..shader = textGradient.createShader(
                          const Rect.fromLTWH(0, 0, 150, 30),
                        ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildImageScroller() {
    if (_homeScreenModel == null) {
      return const SizedBox(
        height: 360,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    final imagePaths = _homeScreenModel!.imageUrls;

    return Column(
      children: [
        SizedBox(
          height: 360,
          child: PageView.builder(
            controller: _pageController,
            itemCount: imagePaths.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(
                  left: index == 0 ? 4 : 1,
                  right: index == imagePaths.length - 1 ? 4 : 1,
                  top: 12,
                  bottom: 12,
                ),
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 0),
                          blurRadius: 12,
                        ),
                      ],
                      image: DecorationImage(
                        image: AssetImage(imagePaths[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(imagePaths.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentIndex == index ? 12 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentIndex == index ? Colors.black : Colors.grey[400],
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _getSlidingWrapper() {
    return Container(
      key: ValueKey<int>(_selectedTabIndex),
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 80),
        child: _getBodyContent(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: UI_COLORS.uiWhiteColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _buildBottomNavBar(context),
        drawer: const SideMenuWidget(),
        body: SafeArea(
          child: Column(
            children: [
              if (_showAppBar) _buildTopContainer(context),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                  ) {
                    final slide = Tween<Offset>(
                      begin: Offset(
                        _selectedTabIndex > _previousTabIndex ? 1.0 : -1.0,
                        0.0,
                      ),
                      end: Offset.zero,
                    ).animate(animation);
                    final fade = CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOut,
                    );

                    return SlideTransition(
                      position: slide,
                      child: FadeTransition(opacity: fade, child: child),
                    );
                  },
                  child: _getSlidingWrapper(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopContainer(BuildContext context) {
    return Container(
      color: UI_COLORS.uiWhiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          decoration: BoxDecoration(
            color: UI_COLORS.uiWhiteColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Builder(
                builder:
                    (context) => IconButton(
                      icon: const Icon(
                        Icons.menu_rounded,
                        size: 28,
                        color: Colors.black,
                      ),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        'Hi There!',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Rahul Dodeja',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'Movatif',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      'assets/images/person.jpg',
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 104, sigmaY: 104),
          child: Container(
            height: 68,
            decoration: BoxDecoration(
              color: const Color(0x1A000E15),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: const Color(0x1AF5F5F5), width: 1),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: SafeArea(
              top: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _navIcon(Icons.home_filled, 0),
                  _imageIcon('assets/images/phonebook.png', 1),
                  _imageIcon('assets/images/heartbeat.png', 2),
                  GestureDetector(
                    onTap: () => _onTabSelected(3),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        border:
                            _selectedTabIndex == 3
                                ? Border.all(color: Colors.white, width: 2)
                                : null,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          'assets/images/person.jpg',
                          fit: BoxFit.cover,
                        ),
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

  Widget _navIcon(IconData icon, int index) {
    return Container(
      width: 56,
      height: 44,
      decoration: BoxDecoration(
        color: _selectedTabIndex == index ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(25),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black, size: 24),
        onPressed: () => _onTabSelected(index),
      ),
    );
  }

  Widget _imageIcon(String assetPath, int index) {
    return Container(
      decoration: BoxDecoration(
        color: _selectedTabIndex == index ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(25),
      ),
      child: IconButton(
        icon: Image.asset(
          assetPath,
          color: Colors.black,
          width: 24,
          height: 24,
        ),
        onPressed: () => _onTabSelected(index),
      ),
    );
  }
}
