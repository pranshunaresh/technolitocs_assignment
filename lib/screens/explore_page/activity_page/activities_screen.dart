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
  bool _loading = true;
  bool _apiWorking = true;

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
          _loading = false;
          _apiWorking = true;
        });
      } else {
        setState(() {
          _loading = false;
          _apiWorking = false;
        });
      }
    } catch (e) {
      setState(() {
        _loading = false;
        _apiWorking = false;
      });
    }
  }

  // Define text styles
  final TextStyle _searchHintStyle = const TextStyle(
    fontFamily: 'Movatif',
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  final TextStyle _searchTextStyle = const TextStyle(
    fontFamily: 'Movatif',
    fontSize: 14,
    color: Colors.black,
  );

  final TextStyle _dateTextStyle = TextStyle(
    // No fontFamily specified - will use default
    color: Colors.grey.shade500,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  final TextStyle _eventTitleStyle = const TextStyle(
    fontFamily: 'Movatif',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    height: 1.3,
  );

  final TextStyle _noEventsTextStyle = const TextStyle(
    fontFamily: 'Movatif',
    color: Colors.red,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 0,
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
                    const Icon(Icons.search, color: Colors.black, size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search by Event, Projects, Initiatives...',
                          hintStyle: _searchHintStyle,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                        ),
                        style: _searchTextStyle,
                      ),
                    ),
                    Image.asset(
                      'assets/images/Funnel.png',
                      color: Colors.black,
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Loading / Error / Event List
              if (_loading)
                const Center(child: CircularProgressIndicator())
              else if (_events.isEmpty)
                Text('No events found', style: _noEventsTextStyle)
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
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlogDetails(blogData: blogData),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                imageUrl,
                                width: 64,
                                height: 64,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (_, __, ___) => Container(
                                      width: 64,
                                      height: 64,
                                      color: Colors.grey[300],
                                      child: const Icon(
                                        Icons.broken_image,
                                        size: 24,
                                      ),
                                    ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(dateStr, style: _dateTextStyle),
                                  const SizedBox(height: 4),
                                  Text(event.title, style: _eventTitleStyle),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.chevron_right,
                              size: 24,
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
    );
  }
}
