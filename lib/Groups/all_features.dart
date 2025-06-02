import 'package:flutter/material.dart';

class AllFeatures extends StatelessWidget {
  const AllFeatures({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'assets/images/backward_arrow_black.png',
            width: 24,
            height: 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),

        centerTitle: true,
        title: const Text(
          'All Features',
          style: TextStyle(
            fontFamily: 'Movatif',
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 38),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 32,
              runSpacing: 32,
              alignment: WrapAlignment.center,
              children: List.generate(6, (index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFF0F0F0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset("assets/images/m5.png"),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'TALKS',
                      style: TextStyle(
                        fontFamily: 'Movatif',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
