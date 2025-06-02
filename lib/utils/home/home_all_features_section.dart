import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllFeatureSection extends StatelessWidget {
  const AllFeatureSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildFeatureButtons();
  }

  Widget _buildFeatureButtons() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'All Features',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: "Movatif",
                ),
              ),
              TextButton.icon(
                onPressed: () {},
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
                  },
                ),
                const SizedBox(width: 12),
                _featureButton(
                  icon: Icons.auto_awesome_outlined,
                  label: 'Projects & CSR',
                  onTap: () {
                    print('Projects & CSR tapped');
                  },
                ),
                const SizedBox(width: 12),
                _featureButton(
                  icon: CupertinoIcons.mic,
                  label: 'Rolbol Talk',
                  onTap: () {
                    print('Rolbol Talk tapped');
                  },
                ),
                const SizedBox(width: 12),
                _featureButton(
                  icon: CupertinoIcons.circle_righthalf_fill,
                  label: 'Conclaves',
                  onTap: () {
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
