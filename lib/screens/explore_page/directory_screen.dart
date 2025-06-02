import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:assihnment_technolitocs/config/model/directory_screen_model.dart';
import 'directory_member_profile.dart'; // Assuming this is the ProfileCard widget file

class Directory extends StatefulWidget {
  const Directory({super.key});

  @override
  State<Directory> createState() => _DirectoryState();
}

class _DirectoryState extends State<Directory> {
  late Future<List<DirectoryProfile>> members;

  @override
  void initState() {
    super.initState();
    members = fetchMembers();
  }

  Future<List<DirectoryProfile>> fetchMembers() async {
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 12),
            _buildFilterButtons(),
            const SizedBox(height: 12),
            FutureBuilder<List<DirectoryProfile>>(
              future: members,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
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
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Container(
        height: 48,
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
    );
  }

  Widget _buildFilterButtons() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _filterChip('All Members'),
          _filterChip('President'),
          _filterChip('Pioneer Members'),
        ],
      ),
    );
  }

  Widget _filterChip(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(label),
      ),
    );
  }

  Widget _buildMemberCards(
    BuildContext context,
    List<DirectoryProfile> members,
  ) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: members.length,
      itemBuilder: (context, index) {
        final member = members[index];

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
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
                  member.profilePicture.startsWith('http')
                      ? member.profilePicture
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
                    member.name,
                    style: const TextStyle(
                      fontFamily: 'Movatif', // Using Movatif font
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (member.defaultStatus.toLowerCase() == "pioneer")
                  _pioneerTag(),
                // Add special tags for Fanish Jain and Anup Mundhra
                if (member.name.toLowerCase().contains('fanish jain') ||
                    member.name.toLowerCase().contains('anup mundhra'))
                  _specialTag(),
              ],
            ),
            subtitle: Text(
              '${member.rbNationalDesignationId ?? member.rbChapterDesignationId ?? ""}, ${member.cityId ?? "Unknown"}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
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

  Widget _specialTag() {
    return Container(
      margin: const EdgeInsets.only(left: 6),
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
