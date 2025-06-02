import 'package:assihnment_technolitocs/utils/ui_colors.dart';
import 'package:flutter/material.dart';

import 'home_recent_update_card.dart';

class RecentUpdatesSection extends StatelessWidget {
  const RecentUpdatesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: UI_COLORS.uiWhiteColor,
      constraints: const BoxConstraints(maxWidth: 400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 18),
            child: Text(
              'Recent Updates',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontFamily: 'Movatif',
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Navigation tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: const [
                  _NavTabContainer(text: 'All Posts', isSelected: true),
                  SizedBox(width: 23),
                  _NavTab(text: 'Events'),
                  SizedBox(width: 23),
                  _NavTab(text: 'Initiatives'),
                  SizedBox(width: 23),
                  _NavTab(text: 'Projects & CSR'),
                  SizedBox(width: 18), // Right padding at end
                ],
              ),
            ),
          ),

          // Update cards
          const UpdateCardWidget(
            title:
                'Join our Community Donation Drive 2025 to help those in need!',
            tagText: 'Food Donation',
            date: 'April 8, 2025',
            imagePath: 'assets/images/ru1.jpg',
            bottomText:
                'Be a part of our Community Donation Drive 2025! Together, we can make a difference in t...',
          ),
          const UpdateCardWidget(
            title:
                'National Confrence 2025 : National Association Realtors India',
            tagText: 'Conference',
            date: 'April 6, 2025',
            imagePath: 'assets/images/ru2.jpg',
            bottomText:
                'The National Conference 2022, hosted by the National Association of Realtors India, brough...',
          ),
          const UpdateCardWidget(
            title:
                'Celebrating Unity: Yoga Day 2022 - A Journey Towards Wellness and Harmony for All',
            tagText: 'Yoga Day',
            date: 'April 8, 2025',
            imagePath: 'assets/images/ru3.jpg',
            bottomText:
                'We invite you to participate in our Community Donation Drive 2023, a heartfelt initiative aime...',
          ),
          const UpdateCardWidget(
            title:
                'Building Connections: A Fun Team Adventure to Strengthen Bonds and Collaboration Together!',
            tagText: 'Event',
            date: 'April 8, 2025',
            imagePath: 'assets/images/ru4.jpg',
            bottomText:
                'Embarking on a Journey of Connection: Join us for an exciting team adventure designed to de...',
          ),
        ],
      ),
    );
  }
}

class _NavTab extends StatelessWidget {
  final String text;

  const _NavTab({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xFF5D5D5D),
      ),
    );
  }
}

class _NavTabContainer extends StatelessWidget {
  final String text;
  final bool isSelected;

  const _NavTabContainer({required this.text, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xffE8E8E8) : Colors.transparent,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }
}
