import 'package:assihnment_technolitocs/Screens/login_screen.dart';
import 'package:assihnment_technolitocs/config/model/user_model.dart';
import 'package:assihnment_technolitocs/screens/download_certificate.dart';
import 'package:assihnment_technolitocs/screens/feedback_and_suggestion_screen.dart';
import 'package:assihnment_technolitocs/screens/profile_enquiry_screen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:assihnment_technolitocs/config/auth_checker.dart';
import 'package:assihnment_technolitocs/screens/profile_edit.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/auth_service.dart' show AuthService;
import 'home_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void onTabSelected(int index, WidgetRef ref) {
    final selectedTabIndex = ref.read(selectedTabProvider);
    if (selectedTabIndex == index) return;

    previousTabIndex = selectedTabIndex;
    ref.read(selectedTabProvider.notifier).state = index;
    showAppBar = index != 3;
  }

  static const String baseImageUrl =
      'https://technolitics-s3-bucket.s3.ap-south-1.amazonaws.com/rolbol-s3-bucket/';

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        var profile = ref.watch(directoryProfileProvider);
        if (profile != null)
          return Container(
            // width: 360,
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFFF3F4F6),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // if(profile!=null)
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      child: CustomPaint(
                        painter: _PatternPainter(),
                        child: Container(
                          padding: const EdgeInsets.only(top: 24, bottom: 72),
                          width: double.infinity,
                          color: Colors.black,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                profile!.name!
                                    .split(' ')
                                    .map(
                                      (word) =>
                                          word.isEmpty
                                              ? word
                                              : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}',
                                    )
                                    .join(' '),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 28,
                                  // height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${profile.rbChapterDesignationArray.length == 0 ? "" : profile.rbChapterDesignationArray[0].name}, "
                                "${profile.chapters.length == 0 ? "" : profile.chapters[0].name + " " + profile.chapters[0].type[0].toUpperCase() + profile.chapters[0].type.substring(1).toLowerCase()} ",

                                style: TextStyle(
                                  color: Color(0xFFB0B0B0),
                                  fontSize: 16,
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -56,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade300),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 6,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl:
                                  "${baseImageUrl}${profile.profilePicture}",
                              width: 112,
                              height: 112,
                              fit: BoxFit.cover,
                              placeholder:
                                  (context, url) => Container(
                                    color: Colors.grey.shade300,
                                    child: const Icon(
                                      Icons.person,
                                      size: 56,
                                      color: Colors.white,
                                    ),
                                  ),
                              errorWidget:
                                  (context, url, error) => Container(
                                    color: Colors.grey.shade300,
                                    child: const Icon(
                                      Icons.person,
                                      size: 56,
                                      color: Colors.white,
                                    ),
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 64),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfilePage(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          height: 1.2,
                        ),
                      ),
                      child: const Text('Edit Profile'),
                    ),
                    Positioned(
                      bottom: 14,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          20,
                          (index) => Container(
                            width: 3,
                            height: 1,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Column(
                    children: [
                      _NavItem(
                        icon: Icons.info_outline,
                        label: 'Profile Enquiries',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProfileEnquiryScreen(),
                            ),
                          );
                        },
                      ),
                      _NavItem(
                        icon: 'assets/images/Certificate.png',
                        label: 'Download Certificate',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CertificateDownloadScreen(),
                            ),
                          );
                        },
                      ),
                      _NavItem(
                        icon: Icons.support_agent_outlined,
                        label: 'Help & Support',
                        onTap: () {},
                      ),
                      _NavItem(
                        icon: 'assets/images/ChatDots.png',
                        label: 'Feedback & Suggestions',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) => FeedbackAndSuggestionsScreen(),
                            ),
                          );
                        },
                      ),

                      // ExpansionTile(
                      //
                      //   title: Text("Feedback & Suggestions",
                      //   style: const TextStyle(
                      //     fontSize: 16,
                      //     color: Colors.black,
                      //     height: 1.2,
                      //   ) ,
                      //   ),
                      //   leading: ImageIcon(Image.asset("assets/images/ChatDots.png").image,size: 24,),
                      //   children: <Widget>[
                      //     ListTile(title: Text("Inner Content 1")),
                      //     ListTile(title: Text("Inner Content 2")),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                TextButton.icon(
                  onPressed: () async {
                    await AuthService.logout(context);

                    onTabSelected(0, ref);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthChecker(),
                      ),
                      (route) => false,
                    );
                  },
                  icon: const Icon(
                    Icons.logout,
                    size: 20,
                    color: Color(0xFF4B5563),
                  ),
                  label: const Text(
                    'Logout',
                    style: TextStyle(
                      color: Color(0xFF4B5563),
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      height: 1.2,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF4B5563),
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                  ),
                ),
                const SizedBox(height: 48),
              ],
            ),
          );
        //guest profile
        else
          return Container(
            // width: 360,
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFFF3F4F6),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // if(profile!=null)
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      child: CustomPaint(
                        painter: _PatternPainter(),
                        child: Container(
                          padding: const EdgeInsets.only(top: 24, bottom: 72),
                          width: double.infinity,
                          color: Colors.black,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Guest",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 28,
                                  // height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 4),
                              // Text(
                              //   "${profile.rbChapterDesignationArray.length==0?"":profile.rbChapterDesignationArray[0].name}, "
                              //       "${profile.chapters.length==0?"":profile.chapters[0].name+" "
                              //       +profile.chapters[0].type[0].toUpperCase()+profile.chapters[0].type.substring(1).toLowerCase()} ",
                              //
                              //   style: TextStyle(
                              //     color: Color(0xFFB0B0B0),
                              //     fontSize: 16,
                              //     height: 1.2,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -56,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade300),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 6,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: "${baseImageUrl}",
                              width: 112,
                              height: 112,
                              fit: BoxFit.cover,
                              placeholder:
                                  (context, url) => Container(
                                    color: Colors.grey.shade300,
                                    child: const Icon(
                                      Icons.person,
                                      size: 56,
                                      color: Colors.white,
                                    ),
                                  ),
                              errorWidget:
                                  (context, url, error) => Container(
                                    color: Colors.grey.shade300,
                                    child: const Icon(
                                      Icons.person,
                                      size: 56,
                                      color: Colors.white,
                                    ),
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 64),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          height: 1.2,
                        ),
                      ),
                      child: const Text('Login'),
                    ),
                    Positioned(
                      bottom: 14,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          20,
                          (index) => Container(
                            width: 3,
                            height: 1,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Column(
                    children: [
                      _NavItem(
                        icon: Icons.info_outline,
                        label: 'Profile Enquiries',
                        onTap: () {},
                      ),
                      _NavItem(
                        icon: 'assets/images/Certificate.png',
                        label: 'Download Certificate',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CertificateDownloadScreen(),
                            ),
                          );
                        },
                      ),
                      _NavItem(
                        icon: Icons.support_agent_outlined,
                        label: 'Help & Support',
                        onTap: () {},
                      ),
                      _NavItem(
                        icon: 'assets/images/ChatDots.png',
                        label: 'Feedback & Suggestions',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) => FeedbackAndSuggestionsScreen(),
                            ),
                          );
                        },
                      ),

                      // ExpansionTile(
                      //
                      //   title: Text("Feedback & Suggestions",
                      //   style: const TextStyle(
                      //     fontSize: 16,
                      //     color: Colors.black,
                      //     height: 1.2,
                      //   ) ,
                      //   ),
                      //   leading: ImageIcon(Image.asset("assets/images/ChatDots.png").image,size: 24,),
                      //   children: <Widget>[
                      //     ListTile(title: Text("Inner Content 1")),
                      //     ListTile(title: Text("Inner Content 2")),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                TextButton.icon(
                  onPressed: () async {
                    // ref.read(directoryProfileProvider.notifier).clearProfile();
                    // ref.read(directoryProfileProvider.notifier).state = null;
                    // print(ref.read(directoryProfileProvider)!=null?ref.read(directoryProfileProvider)!.id:"removed");

                    onTabSelected(0, ref);
                    await AuthService.logout(context);
                    Future.delayed(Duration(seconds: 2));
                    print("logged out????");

                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const AuthChecker(),
                    //   ),
                    //       (route) => false,
                    // );
                  },
                  icon: const Icon(
                    Icons.logout,
                    size: 20,
                    color: Color(0xFF4B5563),
                  ),
                  label: const Text(
                    'Logout',
                    style: TextStyle(
                      color: Color(0xFF4B5563),
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      height: 1.2,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF4B5563),
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                  ),
                ),
                const SizedBox(height: 48),
              ],
            ),
          );
      },
    );
  }
}

class _NavItem extends StatelessWidget {
  final dynamic icon;
  final String label;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,

      // splashColor: Colors.grey.withOpacity(0.2),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),

        child: Row(
          children: [
            if (icon is String)
              Image.asset(icon, width: 20, height: 20)
            else if (icon is IconData)
              Icon(icon, size: 20, color: Colors.black)
            else
              const SizedBox.shrink(),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white.withOpacity(0.2)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;

    const double spacing = 40;
    const double radius = 6;

    for (double x = 0; x < size.width + spacing; x += spacing) {
      for (double y = 0; y < size.height + spacing; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
