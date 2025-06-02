import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../config/model/blog_details_model.dart';

class BlogDetails extends StatelessWidget {
  final BlogData blogData;

  const BlogDetails({Key? key, required this.blogData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double padding = screenWidth * 0.05;
    final double fontSize = screenWidth < 360 ? 12 : 14;

    // Define text styles
    final TextStyle titleStyle = TextStyle(
      fontFamily: 'Movatif',
      fontWeight: FontWeight.bold,
      fontSize: fontSize * 1.4,
    );

    final TextStyle descriptionStyle = TextStyle(
      fontFamily: 'Movatif',
      fontSize: fontSize,
      height: 1.4,
    );

    final TextStyle dateStyle = TextStyle(
      // No fontFamily specified - will use default
      fontSize: fontSize * 0.8,
      fontWeight: FontWeight.w500,
      color: Colors.grey,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Image.asset(
              'assets/images/backward_arrow_black.png',
              width: 24,
              height: 24,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  blogData.bannerImage,
                  width: double.infinity,
                  height: screenWidth * 0.6,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        height: screenWidth * 0.6,
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.broken_image, size: 40),
                      ),
                ),
              ),
              SizedBox(height: padding),
              Text(blogData.postDate, style: dateStyle),
              SizedBox(height: padding * 0.5),
              Text(blogData.title, style: titleStyle),
              SizedBox(height: padding),
              Text(blogData.description, style: descriptionStyle),
            ],
          ),
        ),
      ),
    );
  }
}
