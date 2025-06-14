import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AllGroups extends StatelessWidget {
  const AllGroups({Key? key}) : super(key: key);

  Widget groupCard({
    required String iconAsset,
    required String altText,
    required String title,
    required String description,
    bool useFullImage = false,
  }) {
    Widget imageWidget =
        useFullImage
            ? Container(
              width: 52,
              height: 52,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF30D6EF),
                    Color(0xFF6A81EB),
                    Color(0xFF794CEC),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: ClipOval(
                  child: Image.asset(
                    iconAsset,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    semanticLabel: altText,
                  ),
                ),
              ),
            )
            : Container(
              width: 52,
              height: 52,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF30D6EF),
                    Color(0xFF6A81EB),
                    Color(0xFF794CEC),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      iconAsset,
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                      semanticLabel: altText,
                    ),
                  ),
                ),
              ),
            );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              imageWidget,
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Movatif',
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/arrow_right_tilted.png',
                    width: 18,
                    height: 18,
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Join Now',
                    style: TextStyle(
                      fontFamily: 'Movatif',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xffe8e8e8))),
            ),
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF4B4B4B),
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white, // White background
          statusBarIconBrightness: Brightness.dark, // Black icons/text
          statusBarBrightness: Brightness.light, // For iOS
        ),

        title: const Text(
          'Groups',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            groupCard(
              iconAsset: 'assets/images/groups1.png',
              altText: 'Icon of a person walking with a cane',
              title: 'SIG Travel Buddies',
              description:
                  'Connect with travel enthusiasts and find companions for your next trip.',
            ),
            groupCard(
              iconAsset: 'assets/images/groups5.jpg',
              altText: 'Photo for SIG Movie group',
              title: 'SIG Movie',
              description:
                  'Enjoy and discuss films together in a relaxed setting.',
              useFullImage: true,
            ),
            groupCard(
              iconAsset: 'assets/images/groups2.png',
              altText: 'Icon of a gift box',
              title: 'SIG Pictures',
              description:
                  'Share your favorite pictures and photography moments.',
            ),
            groupCard(
              iconAsset: 'assets/images/groups4.jpg',
              altText: 'Photo for SIG Meditation group',
              title: 'SIG Meditation',
              description: 'Explore mindfulness and relaxation techniques.',
              useFullImage: true,
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text(
                'Clicking will allow you to directly join the respective WhatsApp groups. '
                'Click here to read the Terms & Conditions of the SIG Groups.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
