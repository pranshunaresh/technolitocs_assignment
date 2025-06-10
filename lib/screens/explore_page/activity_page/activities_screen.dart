import 'package:assihnment_technolitocs/config/model/news_blog_event_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
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
  late var _controller;

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
  }

  String? extractYouTubeVideoId(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;

    // Handles https://www.youtube.com/watch?v=VIDEOID
    if (uri.queryParameters.containsKey('v')) {
      return uri.queryParameters['v'];
    }

    // Handles youtu.be/VIDEOID or youtube.com/embed/VIDEOID
    final regExp = RegExp(
      r"(?:v=|\/)([0-9A-Za-z_-]{11}).*",
      caseSensitive: false,
      multiLine: false,
    );

    final match = regExp.firstMatch(url);
    return match?.group(1);
  }

  Widget videoPlayer(String uri) {
    final id = extractYouTubeVideoId(uri);

    final _controller = YoutubePlayerController.fromVideoId(
      videoId: id!,
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );

    return SizedBox(
      height: 64,
      width: 64,
      child: YoutubePlayer(controller: _controller, aspectRatio: 1),
    );
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: false);
    return htmlText
        .replaceAll(exp, '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&');
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
    color: Color.fromRGBO(0, 0, 0, 70),
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  final TextStyle _eventTitleStyle = const TextStyle(
    fontFamily: 'Movatif',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    // height: 1.3,
  );

  final TextStyle _noEventsTextStyle = const TextStyle(
    fontFamily: 'Movatif',
    color: Colors.red,
  );

  @override
  Widget build(BuildContext context) {
    Map<String, List<NewsBlogEventResponses>> _groupedEvents = _groupEvents(
      _events,
    );
    final sortedDates =
        _groupedEvents.keys.toList()..sort(
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
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: sortedDates.length,
                  itemBuilder: (context, index) {
                    final date = sortedDates[index];
                    final events = _groupedEvents[date];

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
                              // margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.only(top: 20, bottom: 16),
                              height: 135,
                              decoration: BoxDecoration(
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
                                        event.bannerImage == ""
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
                                            :
                                            // Text(imageUrl)
                                            Image.network(
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
                                    // videoPlayer(event.bannerVideo)
                                  ),
                                  const SizedBox(width: 16),
                                  Flexible(
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
                                  Center(
                                    child: const Icon(
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

              // ListView.builder(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemCount: _events.length,
              //
              //   itemBuilder: (context, index) {
              //     final event = _events[index];
              //     final dateStr = DateFormat(
              //       'd MMM yyyy',
              //     ).format(event.postDate);
              //
              //     final imageUrl =
              //         'https://technolitics-s3-bucket.s3.ap-south-1.amazonaws.com/rolbol-s3-bucket/${event.bannerImage}';
              //
              //     return GestureDetector(
              //       onTap: () {
              //         final blogData = BlogData(
              //           bannerVideo: event.bannerVideo,
              //           bannerType:event.bannerType,
              //           title: event.title,
              //           bannerImage: imageUrl,
              //           postDate: dateStr,
              //           description: removeAllHtmlTags(event.description),
              //           moreDescription: event.moreDescriptions,
              //         );
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (_) => BlogDetails(blogData: blogData),
              //           ),
              //         );
              //       },
              //       child: Container(
              //         // margin: EdgeInsets.only(bottom: 20),
              //         padding: EdgeInsets.only(top: 20,bottom: 16),
              //         height: 136,
              //         decoration: BoxDecoration(
              //             border: index==0?null:BoxBorder.fromLTRB(top: BorderSide(color: Color(0x1a000000)))
              //         ),
              //         child: Row(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             ClipRRect(
              //               borderRadius: BorderRadius.circular(18),
              //               child: event.bannerImage==""?Image.network(
              //                 'https://img.youtube.com/vi/${extractYouTubeVideoId(event.bannerVideo)}/hqdefault.jpg'                                ,
              //                 width: 104,
              //                 height: 104,
              //                 fit: BoxFit.cover,
              //                 errorBuilder:
              //                     (_, __, ___) => Container(
              //
              //                   width: 104,
              //                   height: 104,
              //                   color: Colors.grey[300],
              //                   child: const Icon(
              //                     Icons.broken_image,
              //                     size: 24,
              //                   ),
              //                 ),
              //               ):
              //               // Text(imageUrl)
              //               Image.network(
              //                 imageUrl,
              //                 width: 104,
              //                 height: 104,
              //                 fit: BoxFit.cover,
              //                 errorBuilder:
              //                     (_, __, ___) => Container(
              //                   width: 104,
              //                   height:104,
              //                   color: Colors.grey[300],
              //                   child: const Icon(
              //                     Icons.broken_image,
              //                     size: 24,
              //                   ),
              //                 ),
              //               )
              //               // videoPlayer(event.bannerVideo)
              //               ,
              //             ),
              //             const SizedBox(width: 16),
              //             Expanded(
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Text(dateStr, style: _dateTextStyle),
              //                   const SizedBox(height: 9),
              //                   Text(event.title.length>100?event.title.substring(0,75)+"...":event.title, style: _eventTitleStyle),
              //                 ],
              //               ),
              //             ),
              //             const SizedBox(width: 8),
              //             const Icon(
              //               Icons.chevron_right,
              //               size: 24,
              //               color: Colors.black,
              //             ),
              //           ],
              //         ),
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
