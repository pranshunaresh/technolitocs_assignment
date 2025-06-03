import 'package:flutter/material.dart';

class UpdateCardWidget extends StatelessWidget {
  final String title;
  final String tagText;
  final String date;
  final String imagePath;
  final String bottomText;

  const UpdateCardWidget({
    Key? key,
    required this.title,
    required this.tagText,
    required this.date,
    required this.imagePath,
    required this.bottomText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xffF5F5F5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xffE8E8E8)),
            boxShadow: [
              const BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 32,
                offset: Offset(0, 12),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontFamily: 'Movatif',
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 36,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffE8E8E8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        tagText,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff5D5D5D),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https://technolitics-s3-bucket.s3.ap-south-1.amazonaws.com/rolbol-s3-bucket/${imagePath}',
                  height: 360,
                  width: 360,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.grey,
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Text(
                bottomText,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff5D5D5D),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
