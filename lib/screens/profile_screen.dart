import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:assihnment_technolitocs/config/auth_checker.dart';
import 'package:assihnment_technolitocs/screens/profile_edit.dart';
import '../config/auth_service.dart' show AuthService;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String baseImageUrl =
      'https://technolitics-s3-bucket.s3.ap-south-1.amazonaws.com/rolbol-s3-bucket/';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 360,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFFF3F4F6),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.menu_rounded,
                                      size: 28,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Scaffold.of(context).openDrawer();
                                    },
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: const [
                                          Text(
                                            'Hi There!',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            'Rahul Dodeja',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontFamily: 'Movatif',
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 8),
                                      CircleAvatar(
                                        radius: 24,
                                        backgroundColor: Colors.grey.shade300,
                                        child: CachedNetworkImage(
                                          imageUrl: baseImageUrl,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                          placeholder:
                                              (context, url) => const Icon(
                                                Icons.person,
                                                size: 24,
                                                color: Colors.white,
                                              ),
                                          errorWidget:
                                              (context, url, error) =>
                                                  const Icon(
                                                    Icons.person,
                                                    size: 24,
                                                    color: Colors.white,
                                                  ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              'Rahul Dodeja',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Member, Raipur Chapter',
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
                            imageUrl: baseImageUrl,
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
                  horizontal: 16,
                  vertical: 10,
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
                      onTap: () {},
                    ),
                    _NavItem(
                      icon: Icons.support_agent_outlined,
                      label: 'Help & Support',
                      onTap: () {},
                    ),
                    _NavItem(
                      icon: 'assets/images/ChatDots.png',
                      label: 'Feedback & Suggestions',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              TextButton.icon(
                onPressed: () async {
                  await AuthService.logout();
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
        ),
      ),
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
      splashColor: Colors.grey.withOpacity(0.2),
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
                fontSize: 14,
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
