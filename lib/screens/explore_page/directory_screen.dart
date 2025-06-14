import 'package:assihnment_technolitocs/config/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:assihnment_technolitocs/config/model/directory_screen_model.dart';
import 'package:marquee/marquee.dart';
import '../../utils/home/home_all_features_section.dart';
import 'directory_member_profile.dart';

final chipIndexForDirectoryProvider = StateProvider<int>((ref) => 0);

class Directory extends ConsumerStatefulWidget {
  const Directory({super.key});

  @override
  ConsumerState<Directory> createState() => _DirectoryState();
}

class _DirectoryState extends ConsumerState<Directory> {
  late Future<List<DirectoryProfile2>> members;
  late TextEditingController _searchController;
  String _searchQuery = '';
  int _chipIndex = 0;
  List<String> filterItems = ["All Members", "Pioneer Members"];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    members = fetchMembers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<List<DirectoryProfile2>> fetchMembers() async {
    const url = 'https://api.rolbol.org/api/v1/directory/allDirectory';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return directoryScreenModelFromJson(response.body);
    } else {
      throw Exception('Failed to load members');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchBar(),
          const SizedBox(height: 20),
          _buildFilterButtons(),
          const SizedBox(height: 20),
          FutureBuilder<List<DirectoryProfile2>>(
            future: members,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      buildPlaceholderItem(true),
                      buildPlaceholderItem(true),
                      buildPlaceholderItem(true),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No members found.'));
              }

              return _buildMemberCards(context, snapshot.data!);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(70),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Center(
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              setState(() {
                _searchQuery = value.toLowerCase();
              });
            },
            decoration: InputDecoration(
              hintText: 'Search by Names, City, or Business Types',
              hintStyle: const TextStyle(fontSize: 14),
              prefixIcon: const Icon(Icons.search, size: 24),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(11.0),
                child: Image.asset(
                  'assets/images/Funnel.png',
                  color: Colors.black,
                  width: 24,
                  height: 24,
                ),
              ),
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(65),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButtons() {
    return SizedBox(
      height: 40,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filterItems.length,
          itemBuilder: (context, index) {
            return Center(child: _filterChip(filterItems[index], index));
          },
        ),
      ),
    );
  }

  Widget _filterChip(String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _chipIndex = (_chipIndex == index) ? 0 : index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _chipIndex == index ? const Color(0x2a000000) : Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(label),
        ),
      ),
    );
  }

  Widget _buildMemberCards(
    BuildContext context,
    List<DirectoryProfile2> members,
  ) {
    final pioneerMembers =
        members.where((m) => m.isPioneerMember == true).toList();

    final searchFiltered =
        _searchQuery.isEmpty
            ? members
            : members
                .where(
                  (member) =>
                      member.name?.toLowerCase().contains(_searchQuery) ??
                      false,
                )
                .toList();

    List<DirectoryProfile2> displayMembers;
    if (_chipIndex == 1) {
      displayMembers =
          _searchQuery.isEmpty
              ? pioneerMembers
              : pioneerMembers
                  .where(
                    (m) =>
                        m.name?.toLowerCase().contains(_searchQuery) ?? false,
                  )
                  .toList();
    } else {
      displayMembers = searchFiltered;
    }

    return Consumer(
      builder: (context, ref, child) {
        final profile = ref.watch(directoryProfileProvider);

        if (displayMembers.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('No matching members found'),
            ),
          );
        }

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: displayMembers.length,
          itemBuilder: (context, index) {
            final member = displayMembers[index];
            final cityString =
                member.chapters!.isNotEmpty
                    ? ", ${member.chapters![0].name}"
                    : "";

            if (profile?.id == member.id) return const SizedBox.shrink();

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileCard(member: member),
                    ),
                  );
                },
                trailing: ImageIcon(
                  Image.asset("assets/images/arrow_right_tilted.png").image,
                  color: Colors.black,
                ),
                leading: Container(
                  width: 54,
                  height: 54,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient:
                        member.isPioneerMember!
                            ? const LinearGradient(
                              colors: [
                                Color(0xFF30D6EF),
                                Color(0xFF6A81EB),
                                Color(0xFF794CEC),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                            : null,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      member.profilePicture!.startsWith('http')
                          ? member.profilePicture!
                          : 'https://technolitics-s3-bucket.s3.ap-south-1.amazonaws.com/rolbol-s3-bucket/${member.profilePicture}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                          ),
                          child: const Icon(Icons.person, size: 30),
                        );
                      },
                    ),
                  ),
                ),
                title: Row(
                  children: [
                    Flexible(
                      child: Container(
                        height: 30,
                        child: AutoScrollText(
                          text: member.name!,
                          fontSize: 17,
                          // hasTag: member.isPioneerMember!,
                        ),
                      ),
                    ),
                    if (member.isPioneerMember!)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: _pioneerTag(),
                      ),
                  ],
                ),
                subtitle: Container(
                  child: Text(
                    '${member.rbChapterDesignationArray![0].name ?? ""}$cityString',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _pioneerTag() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF30D6EF), Color(0xFF6A81EB), Color(0xFF794CEC)],
          stops: [0.0, 0.5, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'Pioneer Member',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildPlaceholderItem(bool isShimmer) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
          ),
          child: const Icon(Icons.person, size: 30, color: Colors.grey),
        ),
        title: Container(height: 20, width: 150, color: Colors.grey[300]),
        subtitle: Container(
          height: 15,
          width: 100,
          margin: const EdgeInsets.only(top: 8),
          color: Colors.grey[300],
        ),
      ),
    );
  }
}
