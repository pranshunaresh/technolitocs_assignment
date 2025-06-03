import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../../config/model/blog_details_model.dart';

class BlogDetails extends StatelessWidget {
  final BlogData blogData;
  final _controller = YoutubePlayerController(
    params: YoutubePlayerParams(
      mute: false,
      showControls: true,
      showFullscreenButton: true,
    ),
  );

  BlogDetails({Key? key, required this.blogData}) : super(key: key);

  String removeAllHtmlTags(String htmlText) {
    if (htmlText.isEmpty) return htmlText;

    final RegExp exp = RegExp(
      r"<[^>]*>",
      multiLine: true,
      caseSensitive: false,
    );

    return htmlText
        .replaceAll(exp, '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'")
        .trim();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final double padding = screenSize.width * 0.05;

    // Responsive font sizing
    final double fontSize = screenSize.width < 360 ? 12 : 14;
    final double imageHeight =
        isPortrait ? screenSize.width * 0.6 : screenSize.height * 0.4;

    // Text styles
    final TextStyle titleStyle = TextStyle(
      fontFamily: 'Movatif',
      fontWeight: FontWeight.bold,
      fontSize: fontSize * 1.4,
      color: Colors.black,
      height: 1.3,
    );

    final TextStyle descriptionStyle = TextStyle(
      fontFamily: 'Movatif',
      fontSize: fontSize,
      height: 1.6,
      color: Colors.black87,
    );

    final TextStyle dateStyle = TextStyle(
      fontSize: fontSize * 0.8,
      fontWeight: FontWeight.w500,
      color: Colors.grey.shade600,
    );

    final cleanedDescription = removeAllHtmlTags(blogData.description);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: false,
          titleSpacing: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero widget for shared image transition
                Hero(
                  tag: 'blog-image-${blogData.title}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      blogData.bannerImage,
                      width: double.infinity,
                      height: imageHeight,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: imageHeight,
                          color: Colors.grey.shade200,
                          child: Center(
                            child: CircularProgressIndicator(
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
                            height: imageHeight,
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.broken_image, size: 40),
                          ),
                    ),
                  ),
                ),
                SizedBox(height: padding),
                Text(blogData.postDate, style: dateStyle),
                SizedBox(height: padding * 0.5),
                Text(blogData.title, style: titleStyle),
                SizedBox(height: padding),
                if (cleanedDescription.isNotEmpty)
                  Text(cleanedDescription, style: descriptionStyle)
                else
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: padding),
                    child: Text(
                      'No description available',
                      style: descriptionStyle.copyWith(color: Colors.grey),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
