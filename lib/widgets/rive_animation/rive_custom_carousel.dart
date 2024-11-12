import 'dart:math';

import 'package:bloc_learner/common/assets.dart';
import 'package:bloc_learner/utils/rive_utils.dart';
import 'package:bloc_learner/widgets/custom_animations/carousel_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RiveCustomCarousel extends StatefulWidget {
  const RiveCustomCarousel({super.key});

  @override
  State<RiveCustomCarousel> createState() => _RiveCustomCarouselState();
}

class _RiveCustomCarouselState extends State<RiveCustomCarousel> {
  int selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Calculate which course item is visible based on the scroll position
    double scrollOffset = _scrollController.position.pixels;
    double itemWidth =
        260.0; // Assuming each course item has a width of 260 + 20 padding
    int currentIndex = (scrollOffset / itemWidth)
        .round(); // Calculate index based on scroll offset

    if (currentIndex != selectedIndex && currentIndex < courses.length) {
      setState(() {
        selectedIndex = currentIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 280,
          margin: const EdgeInsets.only(bottom: 20),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20),
            scrollDirection: Axis.horizontal,
            controller: _scrollController, // Attach the ScrollController
            child: Row(
              children: courses
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: CourseItemWidget(
                        course: e,
                        isSelected: selectedIndex == courses.indexOf(e),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        CarouselIndicator(
          selectedIndex: selectedIndex,
          numberOfDots: courses.length,
        ),
      ],
    );
  }
}

class CourseItemWidget extends StatefulWidget {
  final Course course;
  final bool isSelected;

  const CourseItemWidget({
    super.key,
    required this.course,
    this.isSelected = false,
  });

  @override
  State<CourseItemWidget> createState() => _CourseItemWidgetState();
}

class _CourseItemWidgetState extends State<CourseItemWidget>
    with AutomaticKeepAliveClientMixin {
  late List<String> randomAvatars; // Cache the random avatars here

  @override
  void initState() {
    super.initState();

    // Initialize the random avatars list
    randomAvatars = _getRandomAvatars();
  }

  // Generate random avatars only once when the widget is created
  List<String> _getRandomAvatars() {
    List<String> avatars = [
      Assets.riveAva1,
      Assets.riveAva2,
      Assets.riveAva3,
      Assets.riveAva4,
      Assets.riveAva5,
      Assets.riveAva6,
    ];

    final random = Random();
    return List.generate(3, (_) => avatars[random.nextInt(avatars.length)]);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Ink(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            width: 260,
            decoration: BoxDecoration(
              color: widget.course.bgColors,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.course.title,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 8),
                        child: Text(
                          widget.course.description,
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      const Text(
                        '61 SECTIONS - 11 HOURS',
                        style: TextStyle(
                          color: Colors.white54,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: List.generate(3, (index) {
                          return Transform.translate(
                            offset: Offset((index * -10.0).toDouble(), 0),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage(randomAvatars[index]),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                SvgPicture.asset(widget.course.icon, height: 50, width: 50),
              ],
            ),
          ),
          Container(
            width: 260,
            height: 280,
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? Colors.transparent
                  : Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
