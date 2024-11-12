import 'dart:math';

import 'package:bloc_learner/utils/rive_utils.dart';
import 'package:bloc_learner/widgets/rive_animation/rive_custom_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class RiveHomeScreen extends StatelessWidget {
  final bool isSideClosed;

  const RiveHomeScreen({super.key, required this.isSideClosed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: !isSideClosed
              ? const NeverScrollableScrollPhysics()
              : const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Rive Courses',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontFamily: GoogleFonts.inter().fontFamily,
                      ),
                ),
              ),
              const RiveCustomCarousel(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Recent Courses',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontFamily: GoogleFonts.inter().fontFamily,
                      ),
                ),
              ),
              Column(
                children: recentCourse
                    .map((e) => Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: recentCourseItem(context, course: e),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget recentCourseItem(BuildContext context, {required Course course}) {
    final random = Random();
    return InkWell(
      onTap: () {},
      customBorder: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: ShapeDecoration(
          color: course.bgColors,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    'Watch video - ${random.nextInt(60)} mins',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40,
              child: VerticalDivider(
                color: Colors.white70,
              ),
            ),
            const SizedBox(width: 8),
            SvgPicture.asset(course.icon),
          ],
        ),
      ),
    );
  }
}
