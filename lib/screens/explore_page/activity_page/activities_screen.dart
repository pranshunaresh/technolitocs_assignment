import 'package:assihnment_technolitocs/config/model/news_blog_event_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../../config/model/blog_details_model.dart';
import 'blog_details.dart';

class ActivityScreen extends StatefulWidget {
  final String categoryOfEvent;
  const ActivityScreen({Key? key, required this.categoryOfEvent})
    : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  List<NewsBlogEventResponses> _events = [];
  List<NewsBlogEventResponses> _filteredEvents = [];

  bool _loading = true;
  bool _apiWorking = true;
  late YoutubePlayerController _controller;
  final TextEditingController _searchController = TextEditingController();

  Map<String, List<NewsBlogEventResponses>> _groupEvents(
    List<NewsBlogEventResponses> events,
  ) {
    final DateFormat formatter = DateFormat('dd MMMM yyyy');
    Map<String, List<NewsBlogEventResponses>> grouped = {};

    for (var x in events) {
      String formattedDate = formatter.format(x.postDate);
      grouped.putIfAbsent(formattedDate, () => []);
      grouped[formattedDate]!.add(x);
    }
    return grouped;
  }

  @override
  void initState() {
    super.initState();
    _fetchEventData();

    _controller = YoutubePlayerController(
      params: YoutubePlayerParams(
        mute: false,
        showControls: true,
        showFullscreenButton: true,
      ),
    );

    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredEvents =
          _events
              .where((event) => event.title.toLowerCase().contains(query))
              .toList();
    });
  }

  String? extractYouTubeVideoId(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;
    if (uri.queryParameters.containsKey('v')) {
      return uri.queryParameters['v'];
    }
    final regExp = RegExp(r"(?:v=|\/)([0-9A-Za-z_-]{11}).*");
    final match = regExp.firstMatch(url);
    return match?.group(1);
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: false);
    return htmlText
        .replaceAll(exp, '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&');
  }

  Future<void> _fetchEventData() async {
    String apiUrl =
        'https://api.rolbol.org/api/v1/notification/byNotificationType/${widget.categoryOfEvent}';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final model = newsBlogEventModelFromJson(response.body);
        setState(() {
          _events = model.data;
          _filteredEvents = model.data;
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

  Widget _buildPlaceholder() {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          Container(
            // margin: const EdgeInsets.only(top: 25, bottom: 15),
            // padding: EdgeInsets.symmetric(horizontal: 20),
            child: Container(width: 100, height: 12, color: Colors.grey[300]),
          ),
          buildPlaceholderItem(false),
          buildPlaceholderItem(false),
          buildPlaceholderItem(false),
          buildPlaceholderItem(false),
        ],
      ),
    );
  }

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
    color: Color.fromRGBO(0, 0, 0, 70),
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  final TextStyle _eventTitleStyle = const TextStyle(
    fontFamily: 'Movatif',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  final TextStyle _noEventsTextStyle = const TextStyle(
    fontFamily: 'Movatif',
    color: Colors.red,
  );

  @override
  Widget build(BuildContext context) {
    Map<String, List<NewsBlogEventResponses>> groupedEvents = _groupEvents(
      _filteredEvents,
    );
    final sortedDates =
        groupedEvents.keys.toList()..sort(
          (a, b) => DateFormat(
            'dd MMMM yyyy',
          ).parse(b).compareTo(DateFormat('dd MMMM yyyy').parse(a)),
        );

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
                        controller: _searchController,
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

              if (_loading)
                Container(
                  // margin: EdgeInsets.symmetric(horizontal: 20),
                  child: _buildPlaceholder(),
                )
              else if (_filteredEvents.isEmpty)
                Text('No events found', style: _noEventsTextStyle)
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: sortedDates.length,
                  itemBuilder: (context, index) {
                    final date = sortedDates[index];
                    final events = groupedEvents[date];

                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 25, bottom: 15),
                          child: Text(
                            date,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        ...?events?.map((event) {
                          final imageUrl =
                              'https://technolitics-s3-bucket.s3.ap-south-1.amazonaws.com/rolbol-s3-bucket/${event.bannerImage}';

                          return GestureDetector(
                            onTap: () {
                              final blogData = BlogData(
                                seoSlug: event.seoSlug,
                                bannerVideo: event.bannerVideo,
                                bannerType: event.bannerType,
                                title: event.title,
                                bannerImage: imageUrl,
                                postDate: date,
                                description: removeAllHtmlTags(
                                  event.description,
                                ),
                                moreDescription: event.moreDescriptions,
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => BlogDetails(blogData: blogData),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                top: 20,
                                bottom: 16,
                              ),
                              height: 135,
                              decoration: const BoxDecoration(
                                border: BorderDirectional(
                                  bottom: BorderSide(color: Color(0x1a000000)),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child:
                                        event.bannerImage.isEmpty
                                            ? Image.network(
                                              'https://img.youtube.com/vi/${extractYouTubeVideoId(event.bannerVideo)}/hqdefault.jpg',
                                              width: 104,
                                              height: 104,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (_, __, ___) => Container(
                                                    width: 104,
                                                    height: 104,
                                                    color: Colors.grey[300],
                                                    child: const Icon(
                                                      Icons.broken_image,
                                                      size: 24,
                                                    ),
                                                  ),
                                            )
                                            : Image.network(
                                              imageUrl,
                                              width: 104,
                                              height: 104,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (_, __, ___) => Container(
                                                    width: 104,
                                                    height: 104,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(date, style: _dateTextStyle),
                                        const SizedBox(height: 9),
                                        Text(
                                          event.title,
                                          style: _eventTitleStyle,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Center(
                                    child: Icon(
                                      Icons.chevron_right,
                                      size: 24,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
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

Widget buildPlaceholderItem(bool isDirectory) {
  return Container(
    // margin: EdgeInsets.symmetric(horizontal: 20),
    padding: const EdgeInsets.only(top: 20, bottom: 16),
    height: isDirectory ? 100 : 135,
    decoration: const BoxDecoration(
      border: BorderDirectional(bottom: BorderSide(color: Color(0x1a000000))),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 104,
          height: 104,
          decoration: BoxDecoration(
            // shape: BoxShape.circle,
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: 100, height: 12, color: Colors.grey[300]),
              const SizedBox(height: 9),
              Container(
                width: double.infinity,
                height: 20,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Center(
          child:
              isDirectory
                  ? ImageIcon(
                    Image.asset("assets/images/arrow_right_tilted.png").image,
                    color: Colors.grey,
                  )
                  : Icon(Icons.chevron_right, size: 24, color: Colors.grey),
        ),
      ],
    ),
  );
}
