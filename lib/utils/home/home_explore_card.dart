import 'package:assihnment_technolitocs/Groups/all_groups.dart';
import 'package:assihnment_technolitocs/utils/ui_colors.dart';
import 'package:flutter/material.dart';

class ExploreCard extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final IconData buttonIcon;
  final Color gradientStart;
  final Color gradientEnd;
  final Color? gradientMiddle;
  final List<Map<String, String>> profileImages;

  const ExploreCard({
    Key? key,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.buttonIcon,
    required this.gradientStart,
    required this.gradientEnd,
    this.gradientMiddle, // optional
    required this.profileImages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine the colors list
    List<Color> gradientColors;
    List<double> gradientStops;

    if (gradientMiddle != null) {
      gradientColors = [gradientStart, gradientMiddle!, gradientEnd];
      gradientStops = [0.0, 0.5, 1.0];
    } else {
      // Auto-generate middle color by blending start and end
      final Color autoMiddle = Color.lerp(gradientStart, gradientEnd, 0.5)!;
      gradientColors = [gradientStart, autoMiddle, gradientEnd];
      gradientStops = [0.0, 0.5, 1.0];
    }

    return Container(
      height: 195,
      width: 321.7,
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: gradientColors,
                stops: gradientStops,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // width: 70,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: SizedBox(
                    height: 30,
                    width: 70,
                    child: Center(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontFamily: 'Movatif',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Description with overflow handling
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 19,
                    color: UI_COLORS.uiWhiteColor,
                    fontFamily: 'Movatif',
                  ),
                  overflow: TextOverflow.ellipsis, // Prevent text overflow
                  maxLines: 2, // Limit text to 2 lines
                ),
                const SizedBox(height: 14),
                // Profile Images Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Using Wrap widget to handle overflow in profile images
                    SizedBox(
                      height: 45,
                      width:
                          (profileImages.length - 1) * 35 +
                          45, // dynamic width: (offset * (n - 1)) + image width
                      child: Stack(
                        clipBehavior:
                            Clip.none, // allow overlap beyond bounds if needed
                        children: List.generate(profileImages.length, (index) {
                          final profile = profileImages[index];
                          return Positioned(
                            left: index * 35, // overlap amount
                            child: _buildProfileImage(
                              profile['url']!,
                              profile['semanticLabel']!,
                            ),
                          );
                        }),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Movatif',
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AllGroups(),
                            ),
                          );
                        },

                        icon: Icon(buttonIcon, size: 15, color: Colors.white),
                        label: Text(buttonText),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildProfileImage(String url, String semanticLabel) {
    return Container(
      // margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: ClipOval(
        child: Image.network(
          url,
          width: 45,
          height: 45,
          fit: BoxFit.cover,
          semanticLabel: semanticLabel,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return SizedBox(
              width: 40,
              height: 40,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  value:
                      loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                ),
              ),
            );
          },
          errorBuilder:
              (context, error, stackTrace) => Container(
                width: 45,
                height: 45,
                color: Colors.grey[300],
                child: const Icon(Icons.person, color: Colors.grey),
              ),
        ),
      ),
    );
  }
}
