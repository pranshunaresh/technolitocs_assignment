import 'dart:convert';

import 'package:html/parser.dart' as html_parser;
import 'package:assihnment_technolitocs/config/model/blog_details_model.dart';
import 'package:assihnment_technolitocs/config/model/news_blog_event_model.dart';
import 'package:assihnment_technolitocs/screens/explore_page/activity_page/blog_details.dart';
import 'package:assihnment_technolitocs/utils/ui_colors.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;

import 'home_recent_update_card.dart';

class RecentUpdatesSection extends StatefulWidget {
  const RecentUpdatesSection({Key? key}) : super(key: key);

  @override
  State<RecentUpdatesSection> createState() => _RecentUpdatesSectionState();
}

class _RecentUpdatesSectionState extends State<RecentUpdatesSection> {
  late List<dynamic> postCategoryList;
  Future<Map<String, dynamic>> getRecentUpdates() async {
    final url = "https://api.rolbol.org/api/v1/home/homeTimeline";
    final res = await http.get(Uri.parse(url));
    final data = jsonDecode(res.body);

    return data;
  }

  void updateListValues(dynamic data) async {
    final list = data['data']['postData'];

    recentUpdateButtons = [
      "All Posts", // first index
      ...list
          .map((val) => val["postCategory"]?.toString() ?? "")
          .toSet()
          .toList(),
    ];
    setState(() {});
  }

  final Gradient textGradient = const LinearGradient(
    colors: [Color(0xFF30D6EF), Color(0xFF6A81EB), Color(0xFF794CEC)],
  );

  String removeAllHtmlTags(String htmlText) {
    // RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: false);
    // return htmlText
    //     .replaceAll(exp, '')
    //     .replaceAll('&nbsp;', ' ')
    //     .replaceAll('&amp;', '&');
    final document = html_parser.parse(htmlText);

    // Extract text and preserve structure using outerHtml
    final buffer = StringBuffer();
    final unescape = HtmlUnescape();

    for (var element in document.body!.children) {
      buffer.writeln(unescape.convert(element.text.trim()));
      buffer.writeln(); // Add newline between <p> tags
    }

    return buffer.toString().trim();
  }

  late var _future;
  List<dynamic> recentUpdateButtons = ["All Posts"];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _future = getRecentUpdates();
    });

    _future.then((value) => updateListValues(value));
  }

  int recentUpdateButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: UI_COLORS.uiWhiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Recent Updates',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontFamily: 'Movatif',
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Navigation tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: List.generate(
                  recentUpdateButtons.length,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        recentUpdateButtonIndex = index;
                      });
                    },
                    child: _NavTabContainer(
                      text: recentUpdateButtons[index]
                          .replaceAll('_', ' ')
                          .split(' ')
                          .map(
                            (word) =>
                                word.isNotEmpty
                                    ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
                                    : '',
                          )
                          .join(' '),
                      isSelected: index == recentUpdateButtonIndex,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          FutureBuilder(
            future: getRecentUpdates(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  children: [
                    UpdateCardWidget(
                      title: "",
                      tagText: "",
                      date: DateTime.now().toIso8601String(),
                      imagePath: "",
                      bottomText: "",
                    ),
                    UpdateCardWidget(
                      title: "",
                      tagText: "",
                      date: DateTime.now().toIso8601String(),
                      imagePath: "",
                      bottomText: "",
                    ),
                    UpdateCardWidget(
                      title: "",
                      tagText: "",
                      date: DateTime.now().toIso8601String(),
                      imagePath: "",
                      bottomText: "",
                    ),
                    UpdateCardWidget(
                      title: "",
                      tagText: "",
                      date: DateTime.now().toIso8601String(),
                      imagePath: "",
                      bottomText: "",
                    ),
                    UpdateCardWidget(
                      title: "",
                      tagText: "",
                      date: DateTime.now().toIso8601String(),
                      imagePath: "",
                      bottomText: "",
                    ),
                  ],
                );
              } else if (!snapshot.hasData) {
                return Text("Error!!");
              } else {
                final data = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,
                  physics:
                      NeverScrollableScrollPhysics(), // Prevent nested scrolling

                  itemCount: data['data']['postData'].length,

                  itemBuilder: (context, index) {
                    final data1 = data['data']['postData'][index];

                    // return Text(data1.toString());
                    // print(recentUpdateButtons[recentUpdateButtonIndex]);

                    if (recentUpdateButtonIndex == 0 ||
                        recentUpdateButtons[recentUpdateButtonIndex] ==
                            data1["postCategory"]) {
                      return GestureDetector(
                        onTap: () {
                          final imageUrl =
                              'https://technolitics-s3-bucket.s3.ap-south-1.amazonaws.com/rolbol-s3-bucket/${data1['bannerImage']}';

                          final blogData = BlogData(
                            seoSlug: data1['seoSlug'],
                            description: removeAllHtmlTags(
                              data1["description"],
                            ),
                            bannerVideo: data1['bannerVideo'],
                            bannerType: data1['bannerType'],
                            title: data1['title'],
                            bannerImage: imageUrl,
                            postDate: data1['createdAt'],
                            moreDescription:
                                (data1['moreDescriptions'] as List<dynamic>)
                                    .map(
                                      (item) => MoreDescription.fromJson(
                                        item as Map<String, dynamic>,
                                      ),
                                    )
                                    .toList(),
                          );
                          print(blogData.bannerType);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) => BlogDetails(blogData: blogData),
                            ),
                          );
                        },

                        child: UpdateCardWidget(
                          title: data1['title'],
                          tagText: data1['postCategory'],
                          date: data1['createdAt'],
                          imagePath: data1['bannerImage'],
                          bottomText: removeAllHtmlTags(data1['description']),
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                );
              }
            },
          ),

          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Rest of Life',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    fontFamily: 'Movatif',
                  ),
                ),
                Text(
                  'Best of Life',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Movatif',
                    foreground:
                        Paint()
                          ..shader = textGradient.createShader(
                            const Rect.fromLTWH(0, 0, 150, 30),
                          ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _NavTab extends StatelessWidget {
  final String text;

  const _NavTab({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xFF5D5D5D),
      ),
    );
  }
}

class _NavTabContainer extends StatelessWidget {
  final String text;
  final bool isSelected;

  const _NavTabContainer({required this.text, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xffE8E8E8) : Colors.transparent,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          color: Colors.black,
          // fontFamily: "NotoSans"
        ),
      ),
    );
  }
}
