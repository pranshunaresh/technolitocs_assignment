import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:assihnment_technolitocs/config/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:assihnment_technolitocs/screens/explore_page/activity_page/activities_screen.dart';
import 'package:assihnment_technolitocs/screens/profile_screen.dart';
import 'package:assihnment_technolitocs/utils/home/home_all_features_section.dart';
import 'package:assihnment_technolitocs/utils/home/home_explore_section.dart';
import 'package:assihnment_technolitocs/utils/home/home_recent_update_section.dart';
import 'package:assihnment_technolitocs/utils/ui_colors.dart';
import 'package:assihnment_technolitocs/screens/explore_page/directory_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/home/home_side_menu.dart';

final _controller = ScrollController();

Future<String> fetchTokenFromStorage() async {
  final prefs = await SharedPreferences.getInstance();
  final bearerToken = await prefs.get("access_token").toString();
  return bearerToken;
}

Future<String> fetchUserDataFromApi(String token) async {
  final url = "https://api.rolbol.org/api/v1/adminuser/memberDetails";
  final response = await http.get(
    Uri.parse(url),
    headers: {"Authorization": "Bearer $token"},
  );
  final data = response.body;
  return data;
}

class HomeScreenModel {
  final List<String> imageUrls;
  HomeScreenModel({required this.imageUrls});

  static Future<HomeScreenModel> fetchFromBackend() async {
    final url =
        "http://api.rolbol.org/api/v1/banner/all/MOBILE_APP_SLIDER_BANNER";
    try {
      final response = await http.get(Uri.parse(url));
      // print("Status Code: ${response.statusCode}");
      // print("Response Body: ${response.body}");

      if (response.statusCode != 200) {
        throw Exception("Failed to load banners");
      }

      final json = jsonDecode(response.body);
      final list = json["data"] as List<dynamic>;

      final imgUrls = list.map((val) => val["mobileImage"] as String).toList();
      // print("Extracted Images: $imgUrls");

      return HomeScreenModel(imageUrls: imgUrls);
    } catch (e) {
      print("Error: $e");

      return HomeScreenModel(
        imageUrls: [
          'assets/images/h1.jpg',
          'assets/images/h2.jpg',
          'assets/images/h3.jpg',
        ],
      );
    }
  }
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

int currentIndex = 0;
// int selectedTabIndex = 0;
int previousTabIndex = 0;
bool showAppBar = true;

final selectedTabProvider = StateProvider<int>((ref) => 0);

class _HomeScreenState extends ConsumerState<HomeScreen> {
  HomeScreenModel? _homeScreenModel;

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: false);
    return htmlText
        .replaceAll(exp, '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&');
  }

  final PageController _pageController = PageController(viewportFraction: 0.8);

  Timer? _autoScrollTimer;

  late var data2;
  bool _showLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHomeScreenData();
    _loadData();
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        _showLoading = false;
      });
    });
    _startAutoScroll();
  }

  _loadData() async {
    final token = await fetchTokenFromStorage();
    final data = await fetchUserDataFromApi(token);
    data2 = DirectoryProfile.fromJson(jsonDecode(data)["data"]);
    ref.read(directoryProfileProvider.notifier).updateProfile(data2);

    // print(data2.name);
    // data2 = data;
  }

  Future<void> _loadHomeScreenData() async {
    // print(HomeScreenModel.fetchFromBackend());
    final model = await HomeScreenModel.fetchFromBackend();
    setState(() {
      // print("?//////");
      // print(model.imageUrls);
      _homeScreenModel = model;
      // print(_homeScreenModel!.imageUrls);
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
        currentIndex = (currentIndex + 1) % _homeScreenModel!.imageUrls.length;
        _pageController.animateToPage(
          currentIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void onTabSelected(int index) {
    final selectedTabIndex = ref.read(selectedTabProvider);
    if (selectedTabIndex == index) return;

    previousTabIndex = selectedTabIndex;
    ref.read(selectedTabProvider.notifier).state = index;
    showAppBar = index != 3;
  }

  Widget _getBodyContent() {
    Future.delayed(Duration(seconds: 2));
    switch (ref.watch(selectedTabProvider)) {
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

    return _showLoading
        ? Center(child: CircularProgressIndicator())
        : Consumer(
          builder: (context, ref, child) {
            // print(ref.read(directoryProfileProvider)!.user );

            //
            // print("/////////////////Bearer Token"+profile!.accessToken);
            // print(profile.user);
            // print("/////////////////id"+profile.id);
            //
            // print(profile!.user!.name);
            var profile = ref.watch(directoryProfileProvider);
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  // if (profile != null)
                  // Text(profile.name??"no data"),
                  const SizedBox(height: 12),

                  _buildImageScroller(),

                  const SizedBox(height: 16),
                  const AllFeatureSection(),
                  const SizedBox(height: 12),
                  const ExploreSection(),
                  const SizedBox(height: 12),
                  const RecentUpdatesSection(),
                ],
              ),
            );
          },
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

    return SizedBox(
      height: 412,
      child: PageView.builder(
        controller: _pageController,
        itemCount: imagePaths.length,
        pageSnapping: true,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return Transform.translate(
            offset: Offset(-20, 0),
            child: Padding(
              padding: const EdgeInsets.only(left: 0, right: 20), // shift left
              child: SizedBox(
                width: MediaQuery.of(context).size.width, // full width
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image:
                          imagePaths[index].contains("assets")
                              ? AssetImage(imagePaths[index]) as ImageProvider
                              : NetworkImage(
                                "https://technolitics-s3-bucket.s3.ap-south-1.amazonaws.com/rolbol-s3-bucket/${imagePaths[index]}",
                              ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
    // const SizedBox(height: 12)

    ///icons to show image index below code
    ///
    ///
    ///
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: List.generate(imagePaths.length, (index) {
    //     return AnimatedContainer(
    //       duration: const Duration(milliseconds: 300),
    //       margin: const EdgeInsets.symmetric(horizontal: 4),
    //       width: _currentIndex == index ? 12 : 8,
    //       height: 8,
    //       decoration: BoxDecoration(
    //         color: _currentIndex == index ? Colors.black : Colors.grey[400],
    //         borderRadius: BorderRadius.circular(4),
    //       ),
    //     );
    //   }),
    // ),
  }

  Widget _getSlidingWrapper() {
    return Container(
      key: ValueKey<int>(ref.watch(selectedTabProvider)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 80),
        child: _getBodyContent(),
      ),
    );
  }

  Future<String> fetchDataFromApiUsingBearerToken() async {
    //todo:fetch user data from api using bearertoken
    final prefs = await SharedPreferences.getInstance();
    final bearerToken = await prefs.get("access_token").toString();

    return bearerToken;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        // final asyncProfile  = ref.watch(profileProvider);
        var profile = ref.watch(directoryProfileProvider);

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: showAppBar ? Colors.white : Colors.white,
            statusBarIconBrightness:
                showAppBar ? Brightness.dark : Brightness.light,
            statusBarBrightness:
                showAppBar ? Brightness.dark : Brightness.light,
          ),

          child: Scaffold(
            backgroundColor: UI_COLORS.uiWhiteColor,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: _buildBottomNavBar(context),
            drawer: const SideMenuWidget(),
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: false,
            appBar: _buildCustomAppBar(context, showAppBar),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      transitionBuilder: (
                        Widget child,
                        Animation<double> animation,
                      ) {
                        final slide = Tween<Offset>(
                          begin: Offset(
                            ref.watch(selectedTabProvider) > previousTabIndex
                                ? 1.0
                                : -1.0,
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
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: _getSlidingWrapper(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
                    children: [
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
                        "Rahul Dodeja",
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

  PreferredSize _buildCustomAppBar(BuildContext context, bool showAppBar) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(120), // Adjust height as needed
      child: Consumer(
        builder: (context, ref, child) {
          final profile = ref.watch(directoryProfileProvider);
          if (profile == null) {
            return Center(child: CircularProgressIndicator());
          }

          final imgUrl =
              "https://technolitics-s3-bucket.s3.ap-south-1.amazonaws.com/rolbol-s3-bucket/${profile.profilePicture}";

          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 120),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
              // margin: const EdgeInsets.only(top:30),
              decoration: BoxDecoration(
                color: showAppBar ? Colors.transparent : Colors.black,
                borderRadius: showAppBar ? BorderRadius.circular(16) : null,
              ),
              child: Expanded(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Builder(
                          builder:
                              (context) => IconButton(
                                icon: Icon(
                                  Icons.menu_rounded,
                                  size: 28,
                                  color:
                                      showAppBar ? Colors.black : Colors.white,
                                ),
                                onPressed:
                                    () => Scaffold.of(context).openDrawer(),
                              ),
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Hi There!',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color:
                                        showAppBar
                                            ? Colors.black
                                            : Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  profile.name!
                                      .split(' ')
                                      .map(
                                        (word) =>
                                            word.isEmpty
                                                ? word
                                                : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}',
                                      )
                                      .join(' '),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    color:
                                        showAppBar
                                            ? Colors.black
                                            : Colors.white,
                                    fontFamily: 'Movatif',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  onTabSelected(3);
                                },
                                child: Image.network(
                                  imgUrl,
                                  key: ValueKey(imgUrl),
                                  width: 48,
                                  height: 48,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, e, _) {
                                    return Container(
                                      width: 48,
                                      height: 48,
                                      color: Colors.grey[300],
                                      child:
                                      // Text(e.toString()),
                                      const Icon(Icons.person, size: 24),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final profile = ref.watch(directoryProfileProvider);
        if (profile == null) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }

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
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: SafeArea(
                  top: false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _navIcon(Icons.home_filled, 0),
                      _imageIcon('assets/images/phonebook.png', 1),
                      _imageIcon('assets/images/heartbeat.png', 2),
                      GestureDetector(
                        onTap: () => onTabSelected(3),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // border: _selectedTabIndex == 3
                            //     ? Border.all(color: Colors.black, width: 2)
                            //     : null,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.network(
                              // width: 48,
                              // height: 48,
                              'https://technolitics-s3-bucket.s3.ap-south-1.amazonaws.com/rolbol-s3-bucket/${profile.profilePicture}',
                              fit: BoxFit.cover,
                              errorBuilder: (_, e, __) {
                                return Container(
                                  width: 48,
                                  height: 48,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.person, size: 24),
                                );
                              },
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
      },
    );
  }

  Widget _navIcon(IconData icon, int index) {
    return Container(
      width: 56,
      height: 44,
      decoration: BoxDecoration(
        color:
            ref.watch(selectedTabProvider) == index
                ? Colors.white
                : Colors.transparent,
        borderRadius: BorderRadius.circular(25),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black, size: 24),
        onPressed: () => onTabSelected(index),
      ),
    );
  }

  Widget _imageIcon(String assetPath, int index) {
    return Container(
      width: 56,
      decoration: BoxDecoration(
        color:
            ref.watch(selectedTabProvider) == index
                ? Colors.white
                : Colors.transparent,
        borderRadius: BorderRadius.circular(25),
      ),
      child: IconButton(
        icon: Image.asset(
          assetPath,
          color: Colors.black,
          width: 24,
          height: 24,
        ),
        onPressed: () => onTabSelected(index),
      ),
    );
  }
}
