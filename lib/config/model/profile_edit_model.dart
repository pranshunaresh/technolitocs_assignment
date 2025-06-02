import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileEditModel {
  final bool status;
  final int code;
  final String message;
  final Data data;

  ProfileEditModel({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory ProfileEditModel.fromJson(Map<String, dynamic> json) =>
      ProfileEditModel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  final String name;
  final DateTime dateOfBirth;
  final String bloodGroup;
  final String aboutMember;
  final String rbChapterDesignationName;
  final String profession;
  final String nameOfBusiness;
  final String rppDesignationName;
  final String primaryContactNo;
  final String whatsappContactNo;
  final String emailId;
  final String residentialAddress;
  final String profilePicture;

  Data({
    required this.name,
    required this.dateOfBirth,
    required this.bloodGroup,
    required this.aboutMember,
    required this.rbChapterDesignationName,
    required this.profession,
    required this.nameOfBusiness,
    required this.rppDesignationName,
    required this.primaryContactNo,
    required this.whatsappContactNo,
    required this.emailId,
    required this.residentialAddress,
    required this.profilePicture,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"] ?? '',
    dateOfBirth:
        DateTime.tryParse(json["dateOfBirth"] ?? "") ?? DateTime(2000, 01, 01),
    bloodGroup: json["bloodGroup"] ?? '',
    aboutMember: json["aboutMember"] ?? '',
    rbChapterDesignationName: json["rbChapterDesignationName"] ?? '',
    profession: json["profession"] ?? '',
    nameOfBusiness: json["nameOfBusiness"] ?? '',
    rppDesignationName: json["rppDesignationName"] ?? '',
    primaryContactNo: json["primaryContactNo"] ?? '',
    whatsappContactNo: json["whatsappContactNo"] ?? '',
    emailId: json["emailId"] ?? '',
    residentialAddress: json["residentialAddress"] ?? '',
    profilePicture: json["profilePicture"] ?? '',
  );
}

// ==================== EditProfilePage ====================

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  ProfileEditModel? profileData;
  bool isLoading = false;

  final bioController = TextEditingController();
  final fullNameController = TextEditingController();
  final dobController = TextEditingController();
  final bloodGroupController = TextEditingController();
  final rolbolController = TextEditingController();
  final jobProfileController = TextEditingController();
  final businessNameController = TextEditingController();
  final designationController = TextEditingController();
  final contactNumberController = TextEditingController();
  final whatsappNumberController = TextEditingController();
  final emailController = TextEditingController();
  final formalAddressController = TextEditingController();

  final String apiUrl = 'https://api.rolbol.org/api/v1/adminuser/memberDetails';

  final String bearerToken =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4MmVmNmIyMWU4MWQyZjc2ZmI0Zjk5ZiIsImlhdCI6MTc0NzkwODM0MCwiZXhwIjoxNzc5NDQ0MzQwfQ.D0nGC0WB44d742SM23pwLN6rQ8u6alYofxcJst3uQPc';

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': bearerToken},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        profileData = ProfileEditModel.fromJson(jsonResponse);

        // Populate controllers with API data
        final data = profileData!.data;
        bioController.text = data.aboutMember;
        fullNameController.text = data.name;
        dobController.text = _formatDate(data.dateOfBirth);
        bloodGroupController.text = data.bloodGroup;
        rolbolController.text = data.rbChapterDesignationName;
        jobProfileController.text = data.profession;
        businessNameController.text = data.nameOfBusiness;
        designationController.text = data.rppDesignationName;
        contactNumberController.text = data.primaryContactNo;
        whatsappNumberController.text = data.whatsappContactNo;
        emailController.text = data.emailId;
        formalAddressController.text = data.residentialAddress;
      } else {
        throw Exception('Failed to load profile: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to fetch profile data')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day.toString().padLeft(2, '0')} ${months[date.month - 1]} ${date.year}';
  }

  @override
  void dispose() {
    bioController.dispose();
    fullNameController.dispose();
    dobController.dispose();
    bloodGroupController.dispose();
    rolbolController.dispose();
    jobProfileController.dispose();
    businessNameController.dispose();
    designationController.dispose();
    contactNumberController.dispose();
    whatsappNumberController.dispose();
    emailController.dispose();
    formalAddressController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    // For now just print updated values, you can implement API update here
    print('Saving updated profile...');
    print('Bio: ${bioController.text}');
    print('Full Name: ${fullNameController.text}');
    print('DOB: ${dobController.text}');
    print('Blood Group: ${bloodGroupController.text}');
    print('Rolbol Designation: ${rolbolController.text}');
    print('Job Profile: ${jobProfileController.text}');
    print('Business Name: ${businessNameController.text}');
    print('Designation: ${designationController.text}');
    print('Contact Number: ${contactNumberController.text}');
    print('WhatsApp Number: ${whatsappNumberController.text}');
    print('Email: ${emailController.text}');
    print('Formal Address: ${formalAddressController.text}');

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Changes saved (simulated)')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          icon: Image.asset(
            'assets/images/backward_arrow_black.png',
            width: 20,
            height: 20,
            color: Colors.black87,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: Column(
                  children: [
                    // Profile Image with edit icon
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 48,
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage:
                              profileData != null
                                  ? NetworkImage(
                                    profileData!.data.profilePicture,
                                  )
                                  : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(6),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Update Profile Image',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'PNG, JPG or JPEG',
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                    const SizedBox(height: 24),

                    // Form fields
                    _buildLabeledTextField('Bio', bioController, maxLines: 3),
                    const SizedBox(height: 16),
                    _buildLabeledTextField('Full Name', fullNameController),
                    const SizedBox(height: 16),
                    _buildLabeledTextField('Date of birth', dobController),
                    const SizedBox(height: 16),
                    _buildLabeledTextField('Blood Group', bloodGroupController),
                    const SizedBox(height: 16),
                    _buildLabeledTextField(
                      'Rolbol Designation & Chapter',
                      rolbolController,
                    ),
                    const SizedBox(height: 16),
                    _buildLabeledTextField('Job Profile', jobProfileController),
                    const SizedBox(height: 16),
                    _buildLabeledTextField(
                      'Business Name',
                      businessNameController,
                    ),
                    const SizedBox(height: 16),
                    _buildLabeledTextField(
                      'Designation',
                      designationController,
                    ),
                    const SizedBox(height: 16),
                    _buildLabeledTextField(
                      'Contact Number',
                      contactNumberController,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    _buildLabeledTextField(
                      'WhatsApp Number',
                      whatsappNumberController,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    _buildLabeledTextField(
                      'Email',
                      emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    _buildLabeledTextField(
                      'Formal Address',
                      formalAddressController,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 32),

                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: _saveChanges,
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
    );
  }

  Widget _buildLabeledTextField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            hintText: 'Enter $label',
          ),
        ),
      ],
    );
  }
}
