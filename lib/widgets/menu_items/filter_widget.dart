import 'package:bloc_learner/utils/color_utils.dart';
import 'package:bloc_learner/widgets/menu_items/custom_bottom.dart';
import 'package:flutter/material.dart';

class WidgetFilter extends StatefulWidget {
  final int selectedIndex;
  final List<dynamic> listTitle;
  final bool isShowBottomSheet;
  final Function(dynamic item)? onTap;
  final Widget? action;
  final String Function(dynamic item)? titleItem;

  const WidgetFilter({
    super.key,
    required this.listTitle,
    this.onTap,
    this.titleItem,
    this.action,
    this.isShowBottomSheet = true,
    this.selectedIndex = 0,
  });

  @override
  State<WidgetFilter> createState() => _WidgetFilterState();
}

class _WidgetFilterState extends State<WidgetFilter> with TickerProviderStateMixin {
  int indexSelect = 0;
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: widget.listTitle.length,
      vsync: this,
      initialIndex: widget.selectedIndex,
    );
    indexSelect = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(covariant WidgetFilter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.listTitle.length != oldWidget.listTitle.length) {
      setState(() {
        controller = TabController(
          length: widget.listTitle.length,
          vsync: this,
          initialIndex: widget.selectedIndex,
        );
        indexSelect = widget.selectedIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(horizontal: BorderSide(color: ColorPalette.lineColor)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.action != null) ...[
            widget.action!,
            const SizedBox(width: 6),
          ],
          Expanded(
            child: tabBarWidget(),
          ),
          const SizedBox(width: 7),
          if (widget.isShowBottomSheet)
            InkWell(
              onTap: () {
                CustomBottomSheet.showBottomSheet(
                  context: context,
                  child: ListView.separated(
                    itemCount: widget.listTitle.length,
                    separatorBuilder: (context, index) => Container(
                      height: 0.5,
                      color: ColorPalette.lineColor,
                    ),
                    itemBuilder: (context, index) {
                      dynamic title = widget.listTitle[index];
                      return Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          highlightColor: ColorPalette.hoverColor,
                          onTap: () {
                            setState(() {
                              indexSelect = index;
                            });
                            controller.animateTo(index);

                            widget.onTap?.call(title); // Notify parent with selected category
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            child: Text(
                              (title is String) ? title : widget.titleItem?.call(title) ?? '',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: indexSelect == index ? ColorPalette.orangeColor : ColorPalette.black50Color,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  title: "Bộ lọc",
                );
              },
              child: const Icon(
                Icons.tune_outlined,
                color: ColorPalette.black50Color,
              ),
            ),
        ],
      ),
    );
  }

  Widget tabBarWidget() {
    if (widget.selectedIndex != indexSelect) {
      indexSelect = widget.selectedIndex;
      controller.animateTo(indexSelect);
    }
    return TabBar(
      controller: controller,
      isScrollable: true,
      indicatorColor: Colors.transparent,
      labelPadding: const EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.zero,
      dividerColor: Colors.transparent,
      tabAlignment: TabAlignment.start,
      onTap: (value) {
        setState(() {
          indexSelect = value;
        });
        widget.onTap?.call(widget.listTitle[value]); // Notify parent with selected category
      },
      tabs: [
        for (int i = 0; i < widget.listTitle.length; i++) ...[
          itemWidget(widget.listTitle[i], indexSelect == i),
        ],
      ],
    );
  }

  Widget itemWidget(dynamic title, bool select) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: !select ? Border.all(color: ColorPalette.black50Color) : null,
        gradient: select ? Gradients.defaultGradientBackground : null,
      ),
      padding: EdgeInsets.symmetric(horizontal: !select ? 13.5 : 14, vertical: !select ? 4 : 5),
      child: Text(
        (title is String) ? title : widget.titleItem?.call(title) ?? '',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: select ? Colors.white : ColorPalette.black50Color,
        ),
      ),
    );
  }
}

