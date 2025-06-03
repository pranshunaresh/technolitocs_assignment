import 'package:assihnment_technolitocs/config/model/news_blog_event_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../config/model/blog_details_model.dart';
import 'blog_details.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  List<NewsBlogEventResponses> _events = [];
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchEventData();
  }

  Future<void> _fetchEventData() async {
    const String apiUrl =
        'https://api.rolbol.org/api/v1/notification/byNotificationType/EVENTS';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final model = newsBlogEventModelFromJson(response.body);
        setState(() {
          _events = model.data;
          _isLoading = false;
          _hasError = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _hasError = true;
          _errorMessage = 'Failed to load events: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = 'Error fetching events: ${e.toString()}';
      });
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    await _fetchEventData();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    // Text styles
    final TextStyle searchHintStyle = TextStyle(
      fontFamily: 'Movatif',
      color: Colors.black,
      fontSize: screenSize.width * 0.035,
      fontWeight: FontWeight.w400,
    );

    final TextStyle searchTextStyle = TextStyle(
      fontFamily: 'Movatif',
      fontSize: screenSize.width * 0.035,
      color: Colors.black,
    );

    final TextStyle dateTextStyle = TextStyle(
      color: Colors.grey.shade500,
      fontSize: screenSize.width * 0.03,
      fontWeight: FontWeight.w400,
    );

    final TextStyle eventTitleStyle = TextStyle(
      fontFamily: 'Movatif',
      fontSize: screenSize.width * 0.035,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      height: 1.3,
    );

    final TextStyle errorTextStyle = TextStyle(
      fontFamily: 'Movatif',
      color: Colors.red,
      fontSize: screenSize.width * 0.04,
    );

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
            child: Column(
              children: [
                // Search Bar
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width * 0.04,
                    vertical: screenSize.height * 0.01,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(70),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.black,
                        size: screenSize.width * 0.06,
                      ),
                      SizedBox(width: screenSize.width * 0.03),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText:
                                'Search by Event, Projects, Initiatives...',
                            hintStyle: searchHintStyle,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: screenSize.height * 0.015,
                            ),
                          ),
                          style: searchTextStyle,
                        ),
                      ),
                      Image.asset(
                        'assets/images/Funnel.png',
                        color: Colors.black,
                        width: screenSize.width * 0.06,
                        height: screenSize.width * 0.06,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenSize.height * 0.03),

                // Content Area
                if (_isLoading)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.1,
                      ),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  )
                else if (_hasError)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: screenSize.height * 0.02,
                    ),
                    child: Column(
                      children: [
                        Text(_errorMessage, style: errorTextStyle),
                        SizedBox(height: screenSize.height * 0.02),
                        ElevatedButton(
                          onPressed: _refreshData,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                else if (_events.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: screenSize.height * 0.02,
                    ),
                    child: Text('No events found', style: errorTextStyle),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _events.length,
                    itemBuilder: (context, index) {
                      final event = _events[index];
                      final dateStr = DateFormat(
                        'd MMM yyyy',
                      ).format(event.postDate);
                      final imageUrl =
                          'https://technolitics-s3-bucket.s3.ap-south-1.amazonaws.com/rolbol-s3-bucket/${event.bannerImage}';

                      return GestureDetector(
                        onTap: () {
                          final blogData = BlogData(
                            title: event.title,
                            bannerImage: imageUrl,
                            postDate: dateStr,
                            description: event.description ?? '',
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlogDetails(blogData: blogData),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: screenSize.height * 0.02,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  imageUrl,
                                  width:
                                      isPortrait
                                          ? screenSize.width * 0.16
                                          : screenSize.height * 0.1,
                                  height:
                                      isPortrait
                                          ? screenSize.width * 0.16
                                          : screenSize.height * 0.1,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (
                                    context,
                                    child,
                                    loadingProgress,
                                  ) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      width:
                                          isPortrait
                                              ? screenSize.width * 0.16
                                              : screenSize.height * 0.1,
                                      height:
                                          isPortrait
                                              ? screenSize.width * 0.16
                                              : screenSize.height * 0.1,
                                      color: Colors.grey[300],
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          value:
                                              loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                        ),
                                      ),
                                    );
                                  },
                                  errorBuilder:
                                      (_, __, ___) => Container(
                                        width:
                                            isPortrait
                                                ? screenSize.width * 0.16
                                                : screenSize.height * 0.1,
                                        height:
                                            isPortrait
                                                ? screenSize.width * 0.16
                                                : screenSize.height * 0.1,
                                        color: Colors.grey[300],
                                        child: Icon(
                                          Icons.broken_image,
                                          size: screenSize.width * 0.06,
                                        ),
                                      ),
                                ),
                              ),
                              SizedBox(width: screenSize.width * 0.04),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(dateStr, style: dateTextStyle),
                                    SizedBox(height: screenSize.height * 0.005),
                                    Text(
                                      event.title,
                                      style: eventTitleStyle,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: screenSize.width * 0.02),
                              Icon(
                                Icons.chevron_right,
                                size: screenSize.width * 0.06,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
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
}
