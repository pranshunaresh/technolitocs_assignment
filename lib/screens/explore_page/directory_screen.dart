import 'package:assihnment_technolitocs/config/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:assihnment_technolitocs/config/model/directory_screen_model.dart';
import 'directory_member_profile.dart'; // Assuming this is the ProfileCard widget file

final chipIndexForDirectoryProvider = StateProvider<int>((ref) => 0);

class Directory extends ConsumerStatefulWidget {
  const Directory({super.key});

  @override
  ConsumerState<Directory> createState() => _DirectoryState();
}

class _DirectoryState extends ConsumerState<Directory> {
  late Future<List<DirectoryProfile2>> members;

  @override
  void initState() {
    super.initState();
    members = fetchMembers();
    // _chipIndex = ref.watch(chipIndexForDirectoryProvider);
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
        children: [
          _buildSearchBar(),
          const SizedBox(height: 20),
          _buildFilterButtons(),
          const SizedBox(height: 20),
          FutureBuilder<List<DirectoryProfile2>>(
            future: members,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print(snapshot.error);
                print("///////////////////////////////" + snapshot.toString());
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No members found.'));
              }

              return _buildMemberCards(context, snapshot.data!);
            },
          ),
          // SizedBox(height: 100,),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
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
    return
    // SingleChildScrollView(
    // scrollDirection: Axis.horizontal,
    // padding: const EdgeInsets.symmetric(horizontal: 16),
    // child:
    //
    //
    SizedBox(
      height: 40,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: filterItems.length,
        itemBuilder: (context, index) {
          return Center(child: _filterChip(filterItems[index], index));
        },
      ),
    );
    //);
  }

  var _chipIndex = 0;
  List<String> filterItems = ["All Members", "President", "Pioneer Members"];

  Widget _filterChip(String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_chipIndex == index)
            _chipIndex = 0;
          else
            _chipIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _chipIndex == index ? Color(0x2a000000) : Colors.white,
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
    final filteredMembers =
        members.where((member) => member.isPioneerMember == true).toList();

    return Consumer(
      builder: (context, ref, child) {
        // _chipIndex = ref.watch(chipIndexForDirectoryProvider);

        final profile = ref.watch(directoryProfileProvider);
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _chipIndex == 2 ? filteredMembers.length : members.length,
          itemBuilder: (context, index) {
            final member =
                _chipIndex == 2 ? filteredMembers[index] : members[index];
            final cityString =
                member.chapters!.length > 0
                    ? ", ${member.chapters![0].name}"
                    : "";

            if (profile!.id == member.id) {
              return SizedBox.shrink();
            } else {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileCard(member: member),
                      ),
                    );
                    print(member);
                  },
                  trailing: ImageIcon(
                    Image.asset("assets/images/arrow_right_tilted.png").image,
                    color: Colors.black,
                  ),
                  leading: Container(
                    width: 54,
                    height: 54,
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF30D6EF),
                          Color(0xFF6A81EB),
                          Color(0xFF794CEC),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        member.profilePicture!.startsWith('http')
                            ? member.profilePicture!
                            : 'https://technolitics-s3-bucket.s3.ap-south-1.amazonaws.com/rolbol-s3-bucket/${member.profilePicture}',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.person, size: 30);
                        },
                      ),
                    ),
                  ),

                  title: Row(
                    children: [
                      Flexible(
                        child: Text(
                          member.name!,
                          style: const TextStyle(
                            fontFamily: 'Movatif',
                            fontSize: 17, // Using Movatif font
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      if (member.isPioneerMember!) _pioneerTag(),
                      // Add special tags for Fanish Jain and Anup Mundhra
                      // if (member.name.toLowerCase().contains('fanish jain') ||
                      //     member.name.toLowerCase().contains('anup mundhra'))
                      //   _specialTag(),
                    ],
                  ),
                  subtitle: Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      '${member.rbChapterDesignationArray![0].name ?? ""}${cityString}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
              );
            }
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
}
