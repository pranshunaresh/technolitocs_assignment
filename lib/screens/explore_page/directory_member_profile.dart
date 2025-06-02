import 'package:flutter/material.dart';
import 'package:assihnment_technolitocs/config/model/directory_screen_model.dart';

class ProfileCard extends StatelessWidget {
  final DirectoryProfile member;

  final Color gradientStart = const Color(0xFF30D6EF);
  final Color gradientMid = const Color(0xFF6A81EB);
  final Color gradientEnd = const Color(0xFF794CEC);

  const ProfileCard({Key? key, required this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(member.name),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Gradient box with quote and profile image
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(125, 24, 24, 64),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        gradient: LinearGradient(
                          colors: [gradientStart, gradientEnd],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: Text(
                        member.quote?.isNotEmpty == true
                            ? '”${member.quote}”'
                            : '”Leading the way for a brighter future!”',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          height: 1.33,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Movatif',
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -48,
                      child: Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade300),
                          color: Colors.white,
                        ),
                        child: ClipOval(
                          child:
                              member.profilePicture?.isNotEmpty == true
                                  ? Image.network(
                                    'https://technolitics-s3-bucket.s3.ap-south-1.amazonaws.com/rolbol-s3-bucket/${member.profilePicture}',
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            _buildPlaceholderIcon(),
                                  )
                                  : _buildPlaceholderIcon(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 64),

                // Name with ID below
                Column(
                  children: [
                    Text(
                      member.name
                          .toUpperCase(), // Make name uppercase as in image
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      member.id ?? 'No ID', // Display the member ID
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF4B5563),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Professional Details section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'PROFESSIONAL DETAILS',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Profile section
                      const Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        member.profession?.isNotEmpty == true
                            ? member.profession!
                            : 'Not specified',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Add other professional details here as needed
                      // For example:
                      if (member.businessType?.isNotEmpty == true) ...[
                        const Text(
                          'Business Type',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          member.businessType!,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],

                      if (member.companyName?.isNotEmpty == true) ...[
                        const Text(
                          'Company',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          member.companyName!,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Buttons row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (member.phone?.isNotEmpty == true)
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.call,
                            size: 16,
                            color: Colors.black87,
                          ),
                          label: const Text(
                            'Call',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF3F4F6),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(999),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                    if (member.phone?.isNotEmpty == true)
                      const SizedBox(width: 12),
                    if (member.phone?.isNotEmpty == true)
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.alternate_email,
                            size: 16,
                            color: Colors.black87,
                          ),
                          label: const Text(
                            'WhatsApp',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF3F4F6),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(999),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                    if (member.email?.isNotEmpty == true)
                      const SizedBox(width: 12),
                    if (member.email?.isNotEmpty == true)
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.email_outlined,
                            size: 16,
                            color: Colors.black87,
                          ),
                          label: const Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF3F4F6),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(999),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderIcon() {
    return Container(
      color: Colors.grey.shade200,
      child: const Icon(Icons.person, size: 48, color: Colors.grey),
    );
  }
}
