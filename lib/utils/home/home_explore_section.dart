import 'package:assihnment_technolitocs/utils/home/home_explore_card.dart';
import 'package:flutter/material.dart';

class ExploreSection extends StatelessWidget {
  const ExploreSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 18),
          child: Text(
            "Explore",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              fontFamily: 'Movatif',
            ),
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(width: 16), // Left padding

              ExploreCard(
                title: 'Birthdays',
                description:
                    'Rahul Dodeja, Dr. Ramesh Kothari and\nApurva Jain having birthday today.',
                buttonText: 'Wish Now',
                buttonIcon: Icons.card_giftcard,
                gradientStart: const Color(0xff30D6EF),
                gradientMiddle: const Color(0xff6A81EB),
                gradientEnd: const Color(0xFF794CEC),
                profileImages: [
                  {
                    'url':
                        'https://storage.googleapis.com/a1aa/image/2f7ebe55-d5c8-48ab-ea28-4f90261b5da9.jpg',
                    'semanticLabel': 'Portrait of Rahul Dodeja',
                  },
                  {
                    'url':
                        'https://storage.googleapis.com/a1aa/image/90d59d90-9896-47e4-3bfc-de6e434ea761.jpg',
                    'semanticLabel': 'Portrait of Dr. Ramesh Kothari',
                  },
                  {
                    'url':
                        'https://storage.googleapis.com/a1aa/image/631ea7f8-d803-4e1b-d72b-35b62ab4cf35.jpg',
                    'semanticLabel': 'Portrait of Apurva Jain',
                  },
                ],
              ),

              const SizedBox(width: 0.0), // Space between cards

              ExploreCard(
                title: 'Groups',
                description:
                    'Explore a variety of SIGs and WhatsApp\n groups to join based on your interests.',
                buttonText: 'Explore Groups',
                buttonIcon: Icons.travel_explore,
                gradientStart: const Color(0xFFF7BA2C),
                gradientEnd: const Color(0xFFEA549A),
                profileImages: [
                  {
                    'url': 'https://randomuser.me/api/portraits/men/32.jpg',
                    'semanticLabel': 'Portrait of random user',
                  },
                ],
              ),

              const SizedBox(width: 0), // Right padding
            ],
          ),
        ),
      ],
    );
  }
}
