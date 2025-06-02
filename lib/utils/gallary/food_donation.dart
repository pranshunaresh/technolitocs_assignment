import 'package:flutter/material.dart';

class FoodDonation extends StatelessWidget {
  const FoodDonation({Key? key}) : super(key: key);

  final List<Drive> drives = const [
    Drive(
      title: 'Food Donation',
      imagePath: 'assets/images/food1.jpg',
      altText:
          'Group of children sitting on floor in an indoor setting listening attentively',
      hashtag: '# Help feed those in need',
      heading: 'Join us for our Food Donation Drive!',
      description:
          'Everyone is welcome to contribute—simply select the number of food packets you wish to donate.',
      priceInfo: 'Rs. 150/Packet',
      donationCount: '7,500',
    ),
    Drive(
      title: 'Clothing Drive',
      imagePath: 'assets/images/food2.jpg',
      altText: 'Four children standing outdoors smiling at camera',
      hashtag: '# Help keep people warm',
      heading: 'Donate clothes to our Clothing Drive!',
      description:
          'Everyone is welcome to contribute—help someone stay warm and dignified.',
      priceInfo: 'Rs. 200/Bundle',
      donationCount: '7,500',
    ),
    Drive(
      title: 'Education Funds',
      imagePath: 'assets/images/food3.jpg',
      altText: 'Two children studying together with an adult helping them',
      hashtag: '# Support child education',
      heading:
          'Support our Education Fund by\nparticipating in our Donation Drive!',
      description:
          'Help a child stay in school. Your support covers books, tuition, and other essentials.',
      priceInfo: 'Rs. 300/Student',
      donationCount: '7,500',
    ),
    Drive(
      title: '',
      imagePath: 'assets/images/food3.jpg',
      altText: 'Young girl reading a book in a classroom',
      hashtag: '# Empower through education',
      heading: 'Another chance to support education!',
      description:
          'With Custom Donation, you can contribute any amount you are comfortable with — every rupee counts and helps provide meals to those in need.',
      priceInfo: '',
      donationCount: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Donation', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'assets/images/backward_arrow_black.png',
            width: 24,
            height: 24,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          itemCount: drives.length,
          separatorBuilder: (_, __) => const SizedBox(height: 32),
          itemBuilder: (context, index) {
            final drive = drives[index];
            return DonationCard(drive: drive);
          },
        ),
      ),
    );
  }
}

class DonationCard extends StatelessWidget {
  final Drive drive;

  const DonationCard({Key? key, required this.drive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final packageButtons =
        ['50 Pkts', '100 Pkts', '150 Pkts', '200 Pkts']
            .map(
              (label) => Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      side: const BorderSide(color: Color(0xFFD1D5DB)),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Semantics(
                label: drive.altText,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Color(0xE6DDDDDD), // #DDDDDD overlay
                    BlendMode.modulate, // Choose appropriate blend mode
                  ),
                  child: Image.asset(
                    drive.imagePath,
                    height: 192,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (drive.title.isNotEmpty)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/HandHeart.png',
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          drive.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4B5563),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback:
                      (bounds) => const LinearGradient(
                        colors: [
                          Color(0xFF30D6EF),
                          Color(0xFF6A81EB),
                          Color(0xFF794CEC),
                        ],
                      ).createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      ),
                  child: Text(
                    drive.hashtag,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      color: Colors.white, // This gets masked by ShaderMask
                    ),
                  ),
                ),

                const SizedBox(height: 4),
                Text(
                  drive.heading,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Movatif', // custom font (optional)
                    height: 1.3,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  drive.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF374151),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Choose a Package',
                  style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                ),
                const SizedBox(height: 8),
                Row(children: packageButtons),
                const SizedBox(height: 12),
                Text(
                  drive.priceInfo,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Combined "Donate Now" and "7,500" in one container
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF794CEC),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 6),
                          const Text(
                            'Donate Now',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          if (drive.donationCount.isNotEmpty) ...[
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                drive.donationCount,
                                style: const TextStyle(
                                  color: Color(0xFF794CEC),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    // Read More button remains as is
                    TextButton(
                      onPressed: () {
                        // TODO: Add read more logic
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF374151),
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      child: const Text('Read More'),
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
}

class Drive {
  final String title;
  final String imagePath;
  final String altText;
  final String hashtag;
  final String heading;
  final String description;
  final String priceInfo;
  final String donationCount;

  const Drive({
    required this.title,
    required this.imagePath,
    required this.altText,
    required this.hashtag,
    required this.heading,
    required this.description,
    required this.priceInfo,
    required this.donationCount,
  });
}
