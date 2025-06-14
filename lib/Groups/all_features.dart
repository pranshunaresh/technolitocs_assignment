import 'package:assihnment_technolitocs/screens/merchandise/merchandise_product_screen.dart';
import 'package:assihnment_technolitocs/screens/merchandise/merchandise_screen.dart';
import 'package:assihnment_technolitocs/screens/profile_enquiry_screen.dart';
import 'package:assihnment_technolitocs/utils/gallary/food_donation.dart';
import 'package:assihnment_technolitocs/utils/gallary/gallary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/home_screen.dart';
import '../screens/rolbol_talks_screen.dart';

class AllFeatures extends ConsumerWidget {
  const AllFeatures({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onTabSelected(int index) {
      final selectedTabIndex = ref.read(selectedTabProvider);
      if (selectedTabIndex == index) return;

      previousTabIndex = selectedTabIndex;
      ref.read(selectedTabProvider.notifier).state = index;
      showAppBar = index != 3;
    }

    final features = [
      {'name': 'Food camp', 'icon': Icons.fastfood, 'func': () {}},
      {
        'name': 'Rolbol Conclave',
        'icon': Icons.groups_outlined,
        'func': () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => RolbolTalksScreen(title: "Rolbol Conclave"),
            ),
          );
        },
      },
      {
        'name': 'Tribe',
        'icon': Icons.people_outline,
        'func': () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => RolbolTalksScreen(title: "Rolbol Tribes"),
            ),
          );
        },
      },
      {
        'name': 'Rolbol Podcast',
        'icon': Icons.podcasts_outlined,
        'func': () {},
      },
      {
        'name': 'Gallery',
        'icon': Icons.photo_library_outlined,
        'func': () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => GalleryPage()));
        },
      },
      {
        'name': 'Events',
        'icon': Icons.celebration_outlined,
        'func': () {
          Navigator.pop(context);
          onTabSelected(2);
        },
      },
      {
        'name': 'Projects & CSR',
        'icon': Icons.volunteer_activism_outlined,
        'func': () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => FoodDonation()));
        },
      },
      {
        'name': 'Rolbol Talk',
        'icon': Icons.mic_outlined,
        'func': () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => RolbolTalksScreen(title: "Rolbol Talks"),
            ),
          );
        },
      },
      {
        'name': 'Conclaves',
        'icon': Icons.groups_outlined,
        'func': () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => RolbolTalksScreen(title: "Rolbol Talks"),
            ),
          );
        },
      },
      {
        'name': 'Rolbol Film Festival',
        'icon': Icons.movie_outlined,
        'func': () {},
      },
      {
        'name': 'Member Enquiry',
        'icon': Icons.help_outline_outlined,
        'func': () {
          Navigator.pop(context);
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProfileEnquiryScreen()),
          );
        },
      },
      {
        'name': 'Merchandise',
        'icon': Icons.shopping_bag_outlined,
        'func': () {
          Navigator.pop(context);
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => Merchandise()));
        },
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'assets/images/backward_arrow_black.png',
            width: 24,
            height: 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'All Features',
          style: TextStyle(
            fontFamily: 'Movatif',
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 24,
            mainAxisSpacing: 32,
            childAspectRatio: 0.8,
          ),
          itemCount: features.length,
          itemBuilder: (context, index) {
            final feature = features[index];
            return GestureDetector(
              onTap: feature['func'] as void Function(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFF0F0F0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        feature['icon'] as IconData,
                        size: 24,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    feature['name'] as String,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Movatif',
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
