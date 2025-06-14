import 'package:assihnment_technolitocs/config/model/user_model.dart';
import 'package:assihnment_technolitocs/screens/explore_page/activity_page/activities_screen.dart';
import 'package:assihnment_technolitocs/screens/merchandise/merchandise_screen.dart';
import 'package:assihnment_technolitocs/screens/rolbol_talks_screen.dart';
import 'package:assihnment_technolitocs/utils/gallary/food_donation.dart';
import 'package:assihnment_technolitocs/utils/gallary/gallary.dart';
import 'package:assihnment_technolitocs/utils/home/home_recent_update_section.dart';
import 'package:assihnment_technolitocs/utils/ui_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Groups/all_features.dart';
import '../../screens/download_certificate.dart';
// import '../../screens/edit_profile/download_certificate.dart';
import '../../screens/explore_page/activity_page/blog_details.dart';
import '../../screens/home_screen.dart';
import '../../screens/profile_enquiry_screen.dart';

class SideMenuWidget extends ConsumerStatefulWidget {
  const SideMenuWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends ConsumerState<SideMenuWidget> {
  bool initiativesExpanded = false;
  bool projectsExpanded = false;
  bool insightsExpanded = false;
  bool membersExpanded = false;

  void onTabSelected(int index) {
    final selectedTabIndex = ref.watch(selectedTabProvider);
    if (selectedTabIndex == index) return;

    previousTabIndex = selectedTabIndex;
    ref.read(selectedTabProvider.notifier).state = index;
    showAppBar = index != 3;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        var profile = ref.watch(directoryProfileProvider);
        return Container(
          width: 340,
          height: MediaQuery.of(context).size.height,
          color: UI_COLORS.uiWhiteColor,
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          child: CircleAvatar(
                            radius: 40,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                              child: Image.network(
                                'https://technolitics-s3-bucket.s3.ap-south-1.amazonaws.com/rolbol-s3-bucket/${profile != null ? profile.profilePicture : ''}',
                                width: 48,
                                height: 48,
                                fit: BoxFit.cover,
                                errorBuilder: (_, e, _) {
                                  return Container(
                                    width: 48,
                                    height: 48,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.person, size: 24),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // if(profile!=null)
                            Text(
                              profile != null ? profile.name! : "Guest",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.5,
                                color: Color(0xFF1F2937),
                                fontFamily: 'NotoSans',
                              ),
                            ),
                            const SizedBox(height: 2),
                            if (profile != null)
                              Text(
                                "${profile.chapters.isEmpty ? "" : profile.chapters[0].name}, "
                                "${profile.rbChapterDesignationArray.isEmpty ? "" : profile.rbChapterDesignationArray[0].name} ",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontFamily: 'NotoSans',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        size: 24,
                        color: Colors.black,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // All Features
                ListTile(
                  leading: Image.asset(
                    'assets/images/m1.png',
                    color: Colors.black,
                    width: 24,
                    height: 24,
                  ),
                  title: const Text('All Features', style: _titleStyle),
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllFeatures(),
                      ),
                    );
                  },
                ),

                // Initiatives
                ExpansionTile(
                  initiallyExpanded: initiativesExpanded,
                  onExpansionChanged:
                      (val) => setState(() => initiativesExpanded = val),
                  leading: Image.asset(
                    'assets/images/m2.png',
                    color: Colors.black,
                    width: 24,
                    height: 24,
                  ),
                  title: const Text('Initiatives', style: _titleStyle),
                  trailing: Icon(
                    initiativesExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down_rounded,
                    color: Colors.black,
                    size: 20,
                  ),
                  children: [
                    _SubMenuItem(
                      'Rolbol talks',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    RolbolTalksScreen(title: "Rolbol Talks"),
                          ),
                        );
                      },
                    ),
                    _SubMenuItem(
                      'Coffee Date',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    RolbolTalksScreen(title: "Coffee Date"),
                          ),
                        );
                      },
                    ),
                    _SubMenuItem(
                      'Tribe',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (context) => RolbolTalksScreen(title: "Tribe"),
                          ),
                        );
                      },
                    ),

                    _SubMenuItem(
                      'Robol Film Festival',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (context) => RolbolTalksScreen(
                                  title: "Robol Film Festival",
                                ),
                          ),
                        );
                      },
                    ),
                    _SubMenuItem(
                      'Robol Conclave',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    RolbolTalksScreen(title: "Robol Conclave"),
                          ),
                        );
                      },
                    ),
                    _SubMenuItem(
                      'Rolbol Podcast',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    RolbolTalksScreen(title: "Rolbol Podcast"),
                          ),
                        );
                      },
                    ),
                    _SubMenuItem(
                      'Robol Retreats',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    RolbolTalksScreen(title: "Robol Retreats"),
                          ),
                        );
                      },
                    ),
                  ],
                  childrenPadding: const EdgeInsets.only(left: 36),
                ),

                // Project & CSR
                ExpansionTile(
                  initiallyExpanded: projectsExpanded,
                  onExpansionChanged:
                      (val) => setState(() => projectsExpanded = val),
                  leading: const Icon(
                    CupertinoIcons.cube,
                    size: 20,
                    color: Colors.black,
                  ),
                  title: const Text('Project & CSR', style: _titleStyle),
                  trailing: Icon(
                    projectsExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down_rounded,
                    color: Colors.black,
                    size: 20,
                  ),
                  children: [
                    _SubMenuItem(
                      'Food Donation',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FoodDonation(),
                          ),
                        );
                      },
                    ),
                    _SubMenuItem('Health Camp'),
                    _SubMenuItem('Blood Donation'),
                    _SubMenuItem('Girls Safety and Hygiene'),
                    _SubMenuItem('Cyber Awareness'),
                    _SubMenuItem('Rolbol Skills'),
                    _SubMenuItem('Menu Item'),
                  ],
                  childrenPadding: const EdgeInsets.only(left: 36),
                ),

                // Members
                ExpansionTile(
                  initiallyExpanded: membersExpanded,
                  onExpansionChanged:
                      (val) => setState(() => membersExpanded = val),
                  leading: const Icon(
                    CupertinoIcons.profile_circled,
                    size: 20,
                    color: Colors.black,
                  ),
                  title: const Text('Members', style: _titleStyle),
                  trailing: Icon(
                    membersExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down_rounded,
                    color: Colors.black,
                    size: 20,
                  ),
                  children: [
                    _SubMenuItem(
                      'Members Enquiry',
                      onTap: () {
                        onTabSelected(1);
                        Navigator.of(context).pop();
                      },
                    ),
                    _SubMenuItem(
                      'Pioneer Members',
                      onTap: () {
                        onTabSelected(1);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                  childrenPadding: const EdgeInsets.only(left: 36),
                ),

                // Insights
                ExpansionTile(
                  initiallyExpanded: insightsExpanded,
                  onExpansionChanged:
                      (val) => setState(() => insightsExpanded = val),
                  leading: Image.asset(
                    'assets/images/m4.png',
                    color: Colors.black,
                    width: 24,
                    height: 24,
                  ),
                  title: const Text('Insights', style: _titleStyle),
                  trailing: Icon(
                    insightsExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down_rounded,
                    color: Colors.black,
                    size: 20,
                  ),
                  children: [
                    _SubMenuItem(
                      'Gallery',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GalleryPage(),
                          ),
                        );
                      },
                    ),
                    _SubMenuItem(
                      'Events',
                      onTap: () {
                        Scaffold.of(context).closeDrawer();
                        onTabSelected(2);
                      },
                    ),
                    _SubMenuItem(
                      'Blogs',
                      onTap: () {
                        Scaffold.of(context).closeDrawer();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => Scaffold(
                                  backgroundColor: Colors.white,
                                  appBar: AppBar(
                                    backgroundColor: Colors.transparent,
                                    title: Text(
                                      "Blogs",
                                      style: TextStyle(fontFamily: "Movatif"),
                                    ),
                                    centerTitle: true,
                                    systemOverlayStyle: SystemUiOverlayStyle(
                                      statusBarColor: Colors.white,
                                      statusBarIconBrightness: Brightness.dark,
                                      statusBarBrightness: Brightness.light,
                                    ),
                                  ),
                                  body: SafeArea(
                                    child: SingleChildScrollView(
                                      child: Container(
                                        padding: const EdgeInsets.only(top: .0),
                                        child: ActivityScreen(
                                          categoryOfEvent: "BLOGS",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          ),
                        );
                      },
                    ),
                    _SubMenuItem(
                      'News',
                      onTap: () {
                        Scaffold.of(context).closeDrawer();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => Scaffold(
                                  backgroundColor: Colors.white,
                                  appBar: AppBar(
                                    backgroundColor: Colors.transparent,
                                    title: Text(
                                      "News",
                                      style: TextStyle(fontFamily: "Movatif"),
                                    ),
                                    centerTitle: true,
                                    systemOverlayStyle: SystemUiOverlayStyle(
                                      statusBarColor: Colors.white,
                                      statusBarIconBrightness: Brightness.dark,
                                      statusBarBrightness: Brightness.light,
                                    ),
                                  ),
                                  body: SafeArea(
                                    child: SingleChildScrollView(
                                      child: Container(
                                        padding: const EdgeInsets.only(top: .0),
                                        child: ActivityScreen(
                                          categoryOfEvent: "NEWS",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          ),
                        );
                      },
                    ),
                    const _SubMenuItem('Spotlight'),
                    const _SubMenuItem('Poll'),
                  ],
                  childrenPadding: const EdgeInsets.only(left: 36),
                ),

                // Profile Inquiries
                ListTile(
                  leading: Image.asset(
                    'assets/images/m6.png',
                    color: Colors.black,
                    width: 24,
                    height: 24,
                  ),
                  title: const Text('Profile Enquiries', style: _titleStyle),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProfileEnquiryScreen(),
                      ),
                    );
                  },
                ),

                // Certificates
                ListTile(
                  leading: Image.asset(
                    'assets/images/Certificate.png',
                    width: 24,
                    height: 24,
                  ),
                  title: const Text('Certificates', style: _titleStyle),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CertificateDownloadScreen(),
                      ),
                    );
                  },
                ),

                // Merchandise
                ListTile(
                  leading: const Icon(Icons.checkroom),
                  title: const Text('Merchandise', style: _titleStyle),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Merchandise()),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //
  // fetchBlogDetailsBySlug(String s) {
  //   // Implement your blog fetching logic here
  //   return null;
  // }
}

const TextStyle _titleStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 16,
  color: Colors.black,
  fontFamily: 'NotoSans',
);

class _SubMenuItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const _SubMenuItem(this.title, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              fontFamily: 'NotoSans',
            ),
          ),
        ),
      ),
    );
  }
}
