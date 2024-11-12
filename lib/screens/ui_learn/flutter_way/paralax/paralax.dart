import 'package:bloc_learner/widgets/flutter_way/paralax/exhibition_bottom_sheet.dart';
import 'package:bloc_learner/widgets/flutter_way/paralax/header.dart';
import 'package:bloc_learner/widgets/flutter_way/paralax/sliding_card_view.dart';
import 'package:bloc_learner/widgets/flutter_way/paralax/tabs.dart';
import 'package:flutter/material.dart';

class Paralax extends StatefulWidget {
  const Paralax({super.key});

  @override
  State<Paralax> createState() => _ParalaxState();
}

class _ParalaxState extends State<Paralax> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        fontFamily: 'SF Pro Display',
      ),
      child: const Scaffold(
        // backgroundColor: ,
        body: Stack(
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Header(),
                  SizedBox(height: 40),
                  Tabs(),
                  SizedBox(height: 8),
                  SlidingCardsView(),
                ],
              ),
            ),
            ExhibitionBottomSheet(),
          ],
        ),
      ),
    );
  }
}
