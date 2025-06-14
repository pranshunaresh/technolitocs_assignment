import 'dart:io';
import 'dart:math';

import 'package:assihnment_technolitocs/config/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:assihnment_technolitocs/config/model/directory_screen_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileCard extends StatelessWidget {
  final DirectoryProfile2 member;

  final Color gradientStart = const Color(0xFF30D6EF);
  final Color gradientMid = const Color(0xFF6A81EB);
  final Color gradientEnd = const Color(0xFF794CEC);

  const ProfileCard({Key? key, required this.member}) : super(key: key);

  Future<void> launchPhoneCall(String phoneNumber) async {
    // Clean the phone number (remove all non-digit characters except +)
    phoneNumber = phoneNumber.replaceAll(RegExp(r'[^0-9+]'), '');
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      // Skip canLaunchUrl check since it can be unreliable for tel: URIs
      await launchUrl(phoneUri);
    } catch (e) {
      print('Could not launch $phoneUri: $e');
    }
  }

  Future<void> openWhatsApp({
    required String phoneNumber,
    String? message,
  }) async {
    phoneNumber = phoneNumber.replaceAll(RegExp(r'[^0-9+]'), '');

    String androidUrl =
        "whatsapp://send?phone=$phoneNumber${message != null ? '&text=${Uri.encodeComponent(message)}' : ''}";
    String iosUrl =
        "https://wa.me/$phoneNumber${message != null ? '?text=${Uri.encodeComponent(message)}' : ''}";

    String url = Platform.isAndroid ? androidUrl : iosUrl;

    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        // Fallback for when WhatsApp is not installed on Android
        if (Platform.isAndroid) {
          final fallbackUrl =
              "https://wa.me/$phoneNumber${message != null ? '?text=${Uri.encodeComponent(message)}' : ''}";
          await launchUrl(Uri.parse(fallbackUrl));
        } else {
          throw 'Could not launch WhatsApp';
        }
      }
    } catch (e) {
      print('Error launching WhatsApp: $e');
    }
  }

  Future<void> openEmail({
    required String email,
    String? subject,
    String? body,
  }) async {
    String url = "mailto:$email";
    if (subject != null || body != null) {
      url += "?";
      if (subject != null) {
        url += "subject=${Uri.encodeComponent(subject)}";
      }
      if (body != null) {
        url += subject != null ? "&" : "";
        url += "body=${Uri.encodeComponent(body)}";
      }
    }

    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      print('Error launching email: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(member.defaultStatus);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(member.name!),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final profile = ref.watch(directoryProfileProvider);

          bool sameChapter =
              profile != null
                  ? profile.membershipChapter == member.membershipChapter
                  : false;
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Gradient box with quote and profile image
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(200, 24, 24, 64),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          gradient: LinearGradient(
                            colors: [gradientStart, gradientEnd],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: Text(
                          member.aboutMember?.isNotEmpty == true
                              ? '”${member.aboutMember}”'
                              : '”Leading the way for a brighter future!”',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            height: 1.33,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Movatif',
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -48,
                        child: Container(
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade300),
                            gradient:
                                member.isPioneerMember!
                                    ? LinearGradient(
                                      colors: [
                                        Color(0xFF30D6EF),
                                        Color(0xFF6A81EB),
                                        Color(0xFF794CEC),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )
                                    : null,

                            color: Colors.white,
                          ),
                          child: ClipOval(
                            child:
                                member.profilePicture?.isNotEmpty == true
                                    ? Image.network(
                                      'https://technolitics-s3-bucket.s3.ap-south-1.amazonaws.com/rolbol-s3-bucket/${member.profilePicture}',
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              _buildPlaceholderIcon(),
                                    )
                                    : _buildPlaceholderIcon(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 64),

                  // Name with ID below
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (member.isPioneerMember!) _pioneerTag(),
                      SizedBox(height: 10),
                      Text(
                        member.name!
                            .toUpperCase(), // Make name uppercase as in image
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: max(
                          member.rbChapterDesignationArray!.length,
                          member.chapters!.length,
                        ),
                        itemBuilder: (context, index) {
                          final style = const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF4B5563),
                          );

                          String designationName =
                              (member.rbChapterDesignationArray != null &&
                                      index <
                                          member
                                              .rbChapterDesignationArray!
                                              .length)
                                  ? member
                                          .rbChapterDesignationArray![index]
                                          .name ??
                                      ''
                                  : '';
                          String chapterName =
                              (member.chapters != null &&
                                      index < member.chapters!.length)
                                  ? member.chapters![index].name ?? ''
                                  : '';
                          String chapterType =
                              (member.chapters != null &&
                                      index < member.chapters!.length)
                                  ? member.chapters![index].type ?? ''
                                  : '';

                          String displayText;
                          if (designationName.isNotEmpty &&
                              (chapterName.isNotEmpty ||
                                  chapterType.isNotEmpty)) {
                            displayText =
                                '$designationName, $chapterName $chapterType';
                          } else if (designationName.isNotEmpty) {
                            displayText = designationName;
                          } else if (chapterName.isNotEmpty ||
                              chapterType.isNotEmpty) {
                            displayText = '$chapterName $chapterType';
                          } else {
                            displayText = 'No Data';
                          }

                          return Text(
                            displayText,
                            textAlign: TextAlign.center,
                            style: style,
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (member.primaryContactNo?.isNotEmpty == true)
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              launchPhoneCall(member.primaryContactNo!);
                            },
                            icon: const Icon(
                              Icons.call,
                              size: 16,
                              color: Colors.black87,
                            ),
                            label: const Text(
                              'Call',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF3F4F6),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(999),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                            ),
                          ),
                        ),
                      if (member.primaryContactNo?.isNotEmpty == true)
                        const SizedBox(width: 12),
                      if (member.primaryContactNo?.isNotEmpty == true)
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              openWhatsApp(
                                phoneNumber: member.primaryContactNo!,
                              );
                            },
                            icon: const Icon(
                              Icons.alternate_email,
                              size: 16,
                              color: Colors.black87,
                            ),
                            label: const Text(
                              'WhatsApp',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF3F4F6),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(999),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                            ),
                          ),
                        ),
                      if (member.emailId?.isNotEmpty == true)
                        const SizedBox(width: 12),
                      if (member.emailId?.isNotEmpty == true)
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              openEmail(email: member.emailId!);
                            },
                            icon: const Icon(
                              Icons.email_outlined,
                              size: 16,
                              color: Colors.black87,
                            ),
                            label: const Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF3F4F6),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(999),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Professional Details section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'PROFESSIONAL DETAILS',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Profile section
                        const Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          member.profession?.isNotEmpty == true
                              ? member.profession!
                              : 'Not specified',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Add other professional details here as needed
                        // For example:
                        if (member.industry?.isNotEmpty == true) ...[
                          const Text(
                            'Business Type',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            member.industry!,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],

                        if (member.nameOfBusiness?.isNotEmpty == true) ...[
                          const Text(
                            'Company',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            member.nameOfBusiness!,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          if (sameChapter)
                            const Text(
                              'Primary Contact Number',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          if (sameChapter)
                            Text(
                              member.primaryContactNo!,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                          if (sameChapter) const SizedBox(height: 12),

                          if (sameChapter)
                            const Text(
                              'WhatsApp Contact Number',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          if (sameChapter)
                            Text(
                              member.whatsappContactNo!,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          if (sameChapter) const SizedBox(height: 12),

                          if (sameChapter)
                            const Text(
                              'Address',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          if (sameChapter)
                            Text(
                              member.residentialAddress!,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Buttons row
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _pioneerTag() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: "Movatif",
        ),
      ),
    );
  }

  Widget _buildPlaceholderIcon() {
    return Container(
      color: Colors.grey.shade200,
      child: const Icon(Icons.person, size: 48, color: Colors.grey),
    );
  }
}
