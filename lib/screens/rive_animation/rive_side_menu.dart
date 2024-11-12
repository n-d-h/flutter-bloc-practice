import 'package:bloc_learner/common/assets.dart';
import 'package:bloc_learner/utils/rive_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveSideMenu extends StatefulWidget {
  const RiveSideMenu({super.key});

  @override
  State<RiveSideMenu> createState() => _RiveSideMenuState();
}

class _RiveSideMenuState extends State<RiveSideMenu> {
  RiveBottomItem selected = navButtons.first;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width * 0.8,
        height: size.height,
        color: const Color(0xFF17203A),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              infoCard(),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  'Browse'.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ...navButtons.map(
                (e) => navButton(
                  item: e,
                  press: () {
                    e.input!.change(true);
                    if (selected != e) {
                      setState(() {
                        selected = e;
                      });
                    }
                    Future.delayed(const Duration(seconds: 1), () {
                      e.input!.change(false);
                    });
                  },
                  init: (artBoard) {
                    StateMachineController controller =
                        RiveUtils.getRiveController(
                      artBoard,
                      stateMachineName: e.stateMachineName,
                    );
                    e.input = controller.findSMI("active") as SMIBool;
                  },
                  isActive: selected == e,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  'History'.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ...navButtons2.map(
                    (e) => navButton(
                  item: e,
                  press: () {
                    e.input!.change(true);
                    if (selected != e) {
                      setState(() {
                        selected = e;
                      });
                    }
                    Future.delayed(const Duration(seconds: 1), () {
                      e.input!.change(false);
                    });
                  },
                  init: (artBoard) {
                    StateMachineController controller =
                    RiveUtils.getRiveController(
                      artBoard,
                      stateMachineName: e.stateMachineName,
                    );
                    e.input = controller.findSMI("active") as SMIBool;
                  },
                  isActive: selected == e,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget navButton({
    required RiveBottomItem item,
    required VoidCallback press,
    required ValueChanged<Artboard> init,
    required bool isActive,
  }) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Divider(
            height: 1,
            color: Colors.white24,
          ),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              height: 56,
              width: isActive ? size.width * 0.8 : 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF6792FF),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            ListTile(
              onTap: press,
              leading: SizedBox.square(
                dimension: 34,
                child: RiveAnimation.asset(
                  item.src,
                  artboard: item.artBoard,
                  onInit: init,
                ),
              ),
              title: Text(
                item.title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

  ListTile infoCard() {
    return const ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(
          CupertinoIcons.person,
          color: Colors.white,
        ),
      ),
      title: Text(
        'dwck.hg',
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        'Youtuber',
        style: TextStyle(color: Colors.white60),
      ),
    );
  }
}
