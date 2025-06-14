import 'package:assihnment_technolitocs/Groups/all_features.dart';
import 'package:assihnment_technolitocs/screens/rolbol_talks_screen.dart';
import 'package:assihnment_technolitocs/utils/gallary/food_donation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquee/marquee.dart';

import '../../screens/home_screen.dart';

class AllFeatureSection extends ConsumerWidget {
  final VoidCallback onScrollToD;

  const AllFeatureSection({Key? key, required this.onScrollToD})
    : super(key: key);

  void onTabSelected(int index, WidgetRef ref) {
    final selectedTabIndex = ref.read(selectedTabProvider);
    if (selectedTabIndex == index) return;

    previousTabIndex = selectedTabIndex;
    ref.read(selectedTabProvider.notifier).state = index;
    showAppBar = index != 3;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All Features',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: "Movatif",
                ),
              ),

              TextButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AllFeatures(),
                    ),
                  );
                },
                icon: const Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff5D5D5D),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                label: const Icon(
                  Icons.arrow_forward,
                  size: 14,
                  color: Colors.grey,
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 24),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerRight,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 56,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _featureButton(
                  icon: Icons.celebration_outlined,
                  label: 'Events',
                  onTap: () {
                    print('Events tapped');
                    onTabSelected(2, ref);
                  },
                ),
                const SizedBox(width: 12),
                _featureButton(
                  icon: Icons.auto_awesome_outlined,
                  label: 'Projects & CSR',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => FoodDonation()),
                    );
                  },
                ),
                const SizedBox(width: 12),
                _featureButton(
                  icon: CupertinoIcons.mic,
                  label: 'Rolbol Talk',
                  onTap: () {
                    print('Rolbol Talk tapped');

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                RolbolTalksScreen(title: "Rolbol Talks"),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 12),
                _featureButton(
                  icon: CupertinoIcons.circle_righthalf_fill,
                  label: 'Conclaves',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                RolbolTalksScreen(title: "Rolbol Conclave"),
                      ),
                    );

                    print('Conclaves Talk tapped');
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _featureButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: const Color(0xFFE8E8E8),
      borderRadius: BorderRadius.circular(50),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        splashColor: Colors.grey.withOpacity(0.3),
        highlightColor: Colors.grey.withOpacity(0.2),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 24, color: Colors.black),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Movatif",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AutoScrollText extends StatelessWidget {
  final String text;
  final double fontSize;

  const AutoScrollText({super.key, required this.text, this.fontSize = 16});

  bool isOverflowing({
    required String text,
    required double fontSize,
    required double maxWidth,
    required BuildContext context,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: TextStyle(fontSize: fontSize)),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: double.infinity);

    return textPainter.width > maxWidth;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final shouldScroll = isOverflowing(
          text: text,
          fontSize: fontSize,
          maxWidth: maxWidth,
          context: context,
        );

        return SizedBox(
          width: maxWidth,
          height: fontSize + 10, // adjust if needed
          child:
              shouldScroll
                  ? Marquee(
                    text: text,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontFamily: "Movatif",
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    velocity: 30,
                    blankSpace: 30,
                    pauseAfterRound: Duration(seconds: 1),
                  )
                  : Text(
                    text,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontFamily: "Movatif",
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
        );
      },
    );
  }
}
