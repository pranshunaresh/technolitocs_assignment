import 'dart:convert';
import 'package:assihnment_technolitocs/config/model/user_model.dart';
import 'package:assihnment_technolitocs/screens/home_screen.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restart_app/restart_app.dart';

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
        DateTime.tryParse(json["dateOfBirth"] ?? "") ?? DateTime(2000, 1, 1),
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

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  ProfileEditModel? profileData;
  bool isLoading = false;

  // List of all blood group types
  final List<String> bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

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

  // final String bearerToken =
  //     'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4MmVmNmIyMWU4MWQyZjc2ZmI0Zjk5ZiIsImlhdCI6MTc0NzkwODM0MCwiZXhwIjoxNzc5NDQ0MzQwfQ.D0nGC0WB44d742SM23pwLN6rQ8u6alYofxcJst3uQPc';

  late String bt3;
  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  File? _selectedImage;

  Future<void> _uploadProfilePicture() async {
    if (_selectedImage == null) return;

    setState(() {
      isLoading = true;
    });

    try {
      final request = http.MultipartRequest(
        'PUT',
        Uri.parse(
          'https://api.rolbol.org/api/v1/adminuser/updateMemberProfile',
        ),
      );

      request.headers['Authorization'] = "Bearer $bt3";
      request.files.add(
        await http.MultipartFile.fromPath(
          'profilePicture',
          _selectedImage!.path,
        ),
      );

      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      print(responseData + "response data /////////////");
      final jsonResponse = json.decode(responseData);
      // ref.read(directoryProfileProvider.notifier);

      if (response.statusCode == 200 && jsonResponse['status'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile picture updated successfully')),
        );
        // Refresh profile data to show new image

        final profile = ref.read(directoryProfileProvider);
        profile!.copyWith(profilePicture: jsonResponse["data"]);

        ref.read(directoryProfileProvider.notifier).updateProfile(profile);

        print(
          "${profile.profilePicture}   /////////////////////////////profile var ki pfp",
        );

        print(
          "${ref.read(directoryProfileProvider)!.profilePicture}  ////////////////////////////////provider ki pfp",
        );

        await fetchProfileData();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: ${jsonResponse['message']}')),
        );
      }
    } catch (e) {
      debugPrint(
        '\n\n\n\n **********************Error uploading image: $e \n\n\n\n\n',
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to upload image')));
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      await _uploadProfilePicture(); // Auto-upload after selection
    }
  }

  Future<void> fetchProfileData() async {
    bt3 = await fetchTokenFromStorage();
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': "Bearer $bt3"},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        profileData = ProfileEditModel.fromJson(jsonResponse);
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
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to fetch profile data')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
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

  Future<void> _saveChanges() async {
    if (fullNameController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Full name is required')));
      return;
    }

    setState(() {
      isLoading = true;
    });

    final Map<String, dynamic> updatedData = {
      "name": fullNameController.text.trim(),
      "dateOfBirth": _parseDateForApi(dobController.text.trim()),
      "bloodGroup": bloodGroupController.text.trim(),
      "aboutMember": bioController.text.trim(),
      "profession": jobProfileController.text.trim(),
      "nameOfBusiness": businessNameController.text.trim(),
      "primaryContactNo": contactNumberController.text.trim(),
      "whatsappContactNo": whatsappNumberController.text.trim(),
      "emailId": emailController.text.trim(),
      "residentialAddress": formalAddressController.text.trim(),

      "rbChapterDesignationName": rolbolController.text.trim(),
      "rppDesignationName": designationController.text.trim(),
    };

    try {
      final response = await http.put(
        Uri.parse('https://api.rolbol.org/api/v1/adminuser/updateMember'),
        headers: {
          'Authorization': "Bearer $bt3",
          'Content-Type': 'application/json',
        },
        body: jsonEncode(updatedData),
      );

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        if (responseJson['status'] == true) {
          print(responseJson);
          final profile = ref.read(directoryProfileProvider);
          // profile!.copyWith(profilePicture: ["data"]);

          // ref.read(directoryProfileProvider.notifier).updateProfile(profile);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully')),
          );
          // Refresh the data after successful update
          await fetchProfileData();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Update failed: ${responseJson['message']}'),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${response.statusCode} - ${response.body}'),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error updating profile: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to update profile')));
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  String _parseDateForApi(String dateStr) {
    try {
      final parts = dateStr.split(' ');
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final month = _monthStringToInt(parts[1]);
        final year = int.parse(parts[2]);
        final date = DateTime(year, month, day);
        return date.toUtc().toIso8601String();
      }
    } catch (_) {}
    return DateTime(2000, 1, 1).toUtc().toIso8601String();
  }

  int _monthStringToInt(String month) {
    const months = {
      'Jan': 1,
      'Feb': 2,
      'Mar': 3,
      'Apr': 4,
      'May': 5,
      'Jun': 6,
      'Jul': 7,
      'Aug': 8,
      'Sep': 9,
      'Oct': 10,
      'Nov': 11,
      'Dec': 12,
    };
    return months[month] ?? 1;
  }

  void onTabSelected(int index) {
    final selectedTabIndex = ref.watch(selectedTabProvider);
    if (selectedTabIndex == index) return;

    previousTabIndex = selectedTabIndex;
    ref.read(selectedTabProvider.notifier).state = index;
    showAppBar = index != 3;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (_, _) {
        Phoenix.rebirth(context);
        onTabSelected(0);
      },
      child: Scaffold(
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
              // setState(() {});
              // Restart.restartApp(notificationTitle: "Restarting Please Wait");
              // ref.refresh(directoryProfileProvider);
              // print('/////////////////////${MediaQuery.of(context).size.height}height///////////////${MediaQuery.of(context).size.width}');
              Navigator.pop(context);
              Phoenix.rebirth(context);
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey[200],
                          child:
                              isLoading && _selectedImage != null
                                  ? const CircularProgressIndicator()
                                  : null,
                          backgroundImage:
                              isLoading && _selectedImage != null
                                  ? null
                                  : _selectedImage != null
                                  ? FileImage(_selectedImage!)
                                  : (profileData != null &&
                                          profileData!
                                              .data
                                              .profilePicture
                                              .isNotEmpty
                                      ? NetworkImage(
                                        'https://technolitics-s3-bucket.s3.ap-south-1.amazonaws.com/rolbol-s3-bucket/${profileData!.data.profilePicture}',
                                      )
                                      : const AssetImage(
                                            'assets/images/profile_placeholder.png',
                                          )
                                          as ImageProvider),
                        ),
                      ),

                      const SizedBox(height: 16),

                      Center(
                        child: TextButton(
                          onPressed: _pickImage,
                          child: const Text(
                            'Change profile image',
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      const SizedBox(height: 24),

                      // Full Name
                      const Text(
                        'Full Name',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xff7d7d7d),
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextField(
                        controller: fullNameController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Date of Birth
                      const Text(
                        'Date of Birth',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xff7d7d7d),
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextField(
                        controller: dobController,
                        readOnly: true,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.calendar_today),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onTap: () async {
                          DateTime initialDate = DateTime.now();
                          try {
                            initialDate = DateTime.parse(dobController.text);
                          } catch (_) {}

                          final date = await showDatePicker(
                            context: context,
                            initialDate: initialDate,
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );

                          if (date != null) {
                            dobController.text = _formatDate(date);
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // Blood Group (Dropdown)
                      const Text(
                        'Blood Group',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xff7d7d7d),
                        ),
                      ),
                      const SizedBox(height: 4),
                      DropdownButtonFormField<String>(
                        value:
                            bloodGroupController.text.isNotEmpty
                                ? bloodGroupController.text
                                : null,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        items:
                            bloodGroups.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            bloodGroupController.text = newValue!;
                          });
                        },
                        hint: const Text('Select Blood Group'),
                      ),
                      const SizedBox(height: 16),

                      // About Member (Bio)
                      const Text(
                        'About Member',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xff7d7d7d),
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextField(
                        controller: bioController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // RB Chapter Designation Name (read-only)
                      const Text(
                        'RB Chapter Designation Name',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xff7d7d7d),
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextField(
                        controller: rolbolController,
                        readOnly: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          hintText: "(Not editable)",
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Profession
                      const Text(
                        'Profession',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xff7d7d7d),
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextField(
                        controller: jobProfileController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Name of Business
                      const Text(
                        'Name of Business',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xff7d7d7d),
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextField(
                        controller: businessNameController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // RPP Designation Name (read-only)
                      const Text(
                        'RPP Designation Name',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xff7d7d7d),
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextField(
                        controller: designationController,
                        readOnly: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          hintText: "(Not editable)",
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Primary Contact Number
                      const Text(
                        'Primary Contact Number',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xff7d7d7d),
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextField(
                        controller: contactNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // WhatsApp Contact Number
                      const Text(
                        'WhatsApp Contact Number',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xff7d7d7d),
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextField(
                        controller: whatsappNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Email ID
                      const Text(
                        'Email ID',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xff7d7d7d),
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Formal Address
                      const Text(
                        'Formal Address',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xff7d7d7d),
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextField(
                        controller: formalAddressController,
                        maxLines: 2,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Save Changes button
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 36,
                              vertical: 16,
                            ),
                            backgroundColor: const Color(0xff000000),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          onPressed: _saveChanges,
                          child: const Text(
                            'Save Changes',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
