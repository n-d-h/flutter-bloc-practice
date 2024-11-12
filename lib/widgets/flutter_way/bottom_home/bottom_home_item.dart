import 'package:bloc_learner/bloc/switch/switch_bloc.dart';
import 'package:bloc_learner/common/assets.dart';
import 'package:bloc_learner/routes.dart';
import 'package:bloc_learner/utils/color_utils.dart';
import 'package:bloc_learner/widgets/login_widgets/glass_morphism.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


class FlutterWay {
 static Future<dynamic> flutterWayBottomSheet(BuildContext context) {
    final switchBloc = BlocProvider.of<SwitchBloc>(context, listen: false);
    final isDarkMode = switchBloc.state.isSwitched;
    final bgColor =
    isDarkMode ? ColorPalette.darkBackGround : ColorPalette.lightBackGround;
    return showModalBottomSheet(
      backgroundColor: bgColor,
      // backgroundColor: Colors.grey.shade100,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      isScrollControlled: true,
      // showDragHandle: true,
      // enableDrag: true,
      sheetAnimationStyle: AnimationStyle(
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 500),
        reverseDuration: const Duration(milliseconds: 500),
      ),
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          snap: true,
          builder: (_, controller) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 8.0),
                  width: 50.0,
                  height: 5.0,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: controller,
                    physics: const ClampingScrollPhysics(),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(16, 32, 16, 30),
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        alignment: WrapAlignment.center,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Flutter Way',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 20,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          GlassMorphism(
                            start: 0.5,
                            end: 0.2,
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            child: BottomHomeItem(
                              bgColors: [
                                HexColor.fromHex("#4568DC"),
                                HexColor.fromHex('#B06AB3'),
                              ],
                              textColor: Colors.white,
                              route: Routes.paralaxScreen,
                            ),
                          ),
                          const BottomHomeItem(
                            title: 'Minimal Weather',
                            route: Routes.minimalWeatherScreen,
                          ),
                          const BottomHomeItem(),
                          const BottomHomeItem(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}


class BottomHomeItem extends StatelessWidget {
  final List<Color> bgColors;
  final Color textColor;
  final String? route;
  final String image;
  final String title;

  const BottomHomeItem({
    super.key,
    this.bgColors = const [Colors.white],
    this.textColor = Colors.black54,
    this.route,
    this.image = Assets.paralax1,
    this.title = 'Paralax scrolling',
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        if (route != null) {
          Routes.goTo(context, route!);
        }
      },
      child: Ink(
        // padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: bgColors.length > 1 ? null : bgColors.first,
          gradient: bgColors.length > 1
              ? LinearGradient(
                  colors: bgColors,
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: bgColors.first.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 0),
              spreadRadius: 3,
            ),
          ],
        ),
        width: 160,
        height: 230,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Image.asset(
                image,
                width: 160,
                height: 160,
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.all(12),
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.notoSans().fontFamily,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
