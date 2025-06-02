import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;

import 'food_donation.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  late Future<List<GalleryItem>> galleryItems;

  @override
  void initState() {
    super.initState();
    galleryItems = fetchGalleryItems();
  }

  Future<List<GalleryItem>> fetchGalleryItems() async {
    final response = await http.get(
      Uri.parse("https://api.rolbol.org/api/v1/gallery/byGalleryType/images"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List items = data['data'];
      List<GalleryItem> galleryList = [];

      for (var gallery in items) {
        if (gallery['moreDescriptions'] != null &&
            gallery['moreDescriptions'] is List) {
          for (var item in gallery['moreDescriptions']) {
            final image = item['singleImage'];
            final title = item['title'] ?? '';

            if (image != null && image.toString().isNotEmpty) {
              galleryList.add(
                GalleryItem(
                  imageUrl:
                      "https://technolitics-s3-bucket.s3.ap-south-1.amazonaws.com/rolbol-s3-bucket/$image",
                  altText: title,
                ),
              );
            }
          }
        }
      }

      return galleryList;
    }

    throw Exception('Failed to load gallery');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 12),
                _buildFilters(context),
                const SizedBox(height: 12),
                FutureBuilder<List<GalleryItem>>(
                  future: galleryItems,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No images found.'));
                    }

                    final images = snapshot.data!;
                    final heights = [150.0, 180.0, 220.0, 250.0];

                    return MasonryGridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        final imageHeight = heights[index % heights.length];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => FullScreenImage(
                                      imageUrl: images[index].imageUrl,
                                      altText: images[index].altText,
                                    ),
                              ),
                            );
                          },
                          child: Semantics(
                            label: images[index].altText,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                height: imageHeight,
                                color: Colors.grey[300],
                                child: Image.network(
                                  images[index].imageUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  loadingBuilder: (context, child, progress) {
                                    if (progress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Image.asset(
                'assets/images/backward_arrow_black.png',
                width: 20,
                height: 20,
                fit: BoxFit.contain,
                color: Colors.black,
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'GALLERY',
                  style: TextStyle(
                    fontFamily: 'Movatif',
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 24),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'GALLERY',
          style: TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w700,
            color: Color(0xFF6B7280),
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          'See all the glimpses',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildFilters(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          FilterButton(
            imageAsset: 'assets/images/gallary1.png',
            label: 'Food Donation',
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FoodDonation()),
                ),
          ),
          const SizedBox(width: 8),
          FilterButton(
            imageAsset: 'assets/images/gallary2.png',
            label: 'Health Camp',
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FoodDonation()),
                ),
          ),
          const SizedBox(width: 8),
          FilterButton(
            imageAsset: 'assets/images/heartbeat.png',
            label: 'Blood Donation',
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FoodDonation()),
                ),
          ),
        ],
      ),
    );
  }
}

class GalleryItem {
  final String imageUrl;
  final String altText;

  GalleryItem({required this.imageUrl, required this.altText});
}

class FilterButton extends StatelessWidget {
  final String imageAsset;
  final String label;
  final VoidCallback onPressed;

  const FilterButton({
    super.key,
    required this.imageAsset,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFD1D5DB)),
        ),
        child: Row(
          children: [
            Image.asset(imageAsset, width: 16, height: 16),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF374151),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  final String altText;

  const FullScreenImage({
    super.key,
    required this.imageUrl,
    required this.altText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Semantics(
          label: altText,
          child: InteractiveViewer(
            child: Image.network(imageUrl, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
