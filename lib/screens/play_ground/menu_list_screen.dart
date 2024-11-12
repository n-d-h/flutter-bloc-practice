import 'dart:async';

import 'package:bloc_learner/repositories/menu_repositories.dart';
import 'package:bloc_learner/widgets/menu_items/category_header.dart';
import 'package:bloc_learner/widgets/menu_items/horizontal_cate_item.dart';
import 'package:bloc_learner/widgets/menu_items/vertical_item.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MenuListScreen extends StatefulWidget {
  const MenuListScreen({super.key});

  @override
  State<MenuListScreen> createState() => _MenuListScreenState();
}

class _MenuListScreenState extends State<MenuListScreen> {
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
  ItemPositionsListener.create();
  final ItemScrollController _horizontalItemScrollController =
  ItemScrollController();
  final ItemPositionsListener _horizontalItemPositionsListener =
  ItemPositionsListener.create();

  final menuList = MenuRepositories.fetchMenu();
  final List<GlobalKey> _categoryKeys = [];
  double _totalCategoryWidth = 0;

  int _selectedCategoryIndex = 0;
  bool _isProgrammaticScroll = false;

  @override
  void initState() {
    super.initState();
    _itemPositionsListener.itemPositions.addListener(_onItemPositionsChange);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateTotalCategoryWidth();
    });
  }

  @override
  void dispose() {
    _itemPositionsListener.itemPositions.removeListener(_onItemPositionsChange);
    super.dispose();
  }

  void _calculateTotalCategoryWidth() {
    double totalWidth = 0;
    for (var key in _categoryKeys) {
      final RenderBox renderBox =
      key.currentContext!.findRenderObject() as RenderBox;
      totalWidth += renderBox.size.width;
    }
    setState(() {
      _totalCategoryWidth =
          totalWidth + (8 * _categoryKeys.length); // Add margin
    });
  }

  void _scrollToCategory(int index) {
    setState(() {
      _selectedCategoryIndex = index;
      _isProgrammaticScroll = true;
    });

    int targetIndex = 0;
    for (int i = 0; i < index; i++) {
      targetIndex += (menuList[i].items.length) + 1; // Add 1 for the header
    }

    _itemScrollController
        .scrollTo(
      index: targetIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    )
        .then((_) {
      Future.delayed(const Duration(milliseconds: 200), () {
        _isProgrammaticScroll = false;
      });
    });

    if (_shouldScrollHorizontally()) {
      _horizontalItemScrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onItemPositionsChange() {
    if (_isProgrammaticScroll) return;

    final positions = _itemPositionsListener.itemPositions.value;
    const screenTopOffset = 0.0;

    for (final position in positions) {
      if (position.itemLeadingEdge <= screenTopOffset &&
          position.itemTrailingEdge > screenTopOffset) {
        final categoryIndex = _getCategoryIndex(position.index);
        if (categoryIndex != -1 && categoryIndex != _selectedCategoryIndex) {
          setState(() {
            _selectedCategoryIndex = categoryIndex;
          });

          if (_shouldScrollHorizontally()) {
            _horizontalItemScrollController.scrollTo(
              index: categoryIndex,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        }
        break;
      }
    }
  }

  bool _shouldScrollHorizontally() {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return _totalCategoryWidth > screenWidth;
  }

  int _getCategoryIndex(int index) {
    int itemCount = 0;
    for (int i = 0; i < menuList.length; i++) {
      if (index < itemCount + (menuList[i].items.length) + 1) return i;
      itemCount += (menuList[i].items.length) + 1;
    }
    return -1;
  }

  int _getHeaderIndex(int categoryIndex) {
    int itemCount = 0;
    for (int i = 0; i < categoryIndex; i++) {
      itemCount += (menuList[i].items.length) + 1;
    }
    return itemCount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu List'),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            constraints: const BoxConstraints(maxHeight: 50),
            child: ScrollablePositionedList.builder(
              itemScrollController: _horizontalItemScrollController,
              itemPositionsListener: _horizontalItemPositionsListener,
              scrollDirection: Axis.horizontal,
              itemCount: menuList.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedCategoryIndex == index;
                final GlobalKey key = GlobalKey();
                _categoryKeys.add(key);

                return GestureDetector(
                  onTap: () => _scrollToCategory(index),
                  child: HorizontalCategoryItem(
                    key: key,
                    category: menuList[index].category,
                    isSelected: isSelected,
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ScrollablePositionedList.builder(
              itemScrollController: _itemScrollController,
              itemPositionsListener: _itemPositionsListener,
              itemCount: menuList.fold<int>(
                0,
                    (prev, menuItem) => prev + (menuItem.items.length) + 1,
              ),
              itemBuilder: (context, index) {
                final categoryIndex = _getCategoryIndex(index);
                final itemIndex = index - _getHeaderIndex(categoryIndex) - 1;

                if (itemIndex == -1) {
                  return CategoryHeader(
                    category: menuList[categoryIndex].category,
                  );
                } else {
                  final item = menuList[categoryIndex].items[itemIndex];
                  return VerticalItem(item: item);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

// class StoreMenuList extends StatefulWidget {
//   final List<FitlerFood> listFitlerFood;
//   final List<FilterAndFood> listFilterAndFoods;
//   final GlobalKey introKey;
//   final GlobalKey introKey2;
//   final ScrollController controller;
//   final double width;
//
//   const StoreMenuList({
//     super.key,
//     required this.listFitlerFood,
//     required this.listFilterAndFoods,
//     required this.width,
//     required this.introKey,
//     required this.controller,
//     required this.introKey2,
//   });
//
//   @override
//   State<StoreMenuList> createState() => _StoreMenuListState();
// }

// class _StoreMenuListState extends State<StoreMenuList> {
//   int _selectedCategoryIndex = 0;
//   bool _isProgrammaticScroll = false;
//   final List<GlobalKey> _categoryHeaderKeys = [];
//   final List<GlobalKey> _categoryItemsKeys = [];
//   final filterKey = GlobalKey<WidgetFilterState>();
//
//   @override
//   void initState() {
//     super.initState();
//     widget.controller.addListener(_onScroll);
//   }
//
//   @override
//   void dispose() {
//     widget.controller.removeListener(_onScroll);
//     super.dispose();
//   }
//
//   void _onScroll() {
//     if (_isProgrammaticScroll) return;
//     if (widget.controller.hasClients) {
//       double offset = widget.controller.offset;
//       double cumulativeHeight = 0;
//
//       RenderBox? intro1 =
//       widget.introKey.currentContext?.findRenderObject() as RenderBox?;
//       RenderBox? intro2 =
//       widget.introKey2.currentContext?.findRenderObject() as RenderBox?;
//       double intro1Height = intro1?.size.height ?? 0;
//       double intro2Height = intro2?.size.height ?? 0;
//       cumulativeHeight += intro1Height + intro2Height;
//
//       for (int i = 0; i < _categoryHeaderKeys.length; i++) {
//         double headerHeight = _getCategoryHeaderHeight(i);
//         double itemsHeight = _getCategoryItemsHeight(i);
//
//         if (offset < cumulativeHeight + headerHeight + itemsHeight) {
//           if (_selectedCategoryIndex != i) {
//             setState(() {
//               _selectedCategoryIndex = i;
//             });
//             // Update the selected category in WidgetFilter
//             _updateSelectedCategoryInFilter(i);
//           }
//           break;
//         }
//         cumulativeHeight += headerHeight + itemsHeight;
//       }
//     }
//   }
//
//   void _updateSelectedCategoryInFilter(int index) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final widgetFilterState = filterKey.currentState;
//       if (widgetFilterState != null) {
//         widgetFilterState.setState(() {
//           widgetFilterState.indexSelect = index;
//           widgetFilterState.id = widget.listFitlerFood[index];
//           widgetFilterState.controller.animateTo(index);
//         });
//       } else {
//         debugPrint('WidgetFilterState is null');
//       }
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return StickyHeader(
//       header: WidgetFilter(
//         key: filterKey,
//         listTitle: widget.listFitlerFood.isNotEmpty
//             ? widget.listFitlerFood
//             : ['Chưa có'],
//         onTap: (item) => _scrollToCategoryHeader(item),
//         titleItem: (item) {
//           return (item as FitlerFood).name;
//         },
//       ),
//       content: Column(
//         children: [
//           if (widget.listFilterAndFoods.isNotEmpty) ...[
//             categoryList(widget.listFilterAndFoods),
//             const SizedBox(height: 10),
//           ] else
//             Center(
//               child: TextCustom(
//                 'Chưa có món ăn',
//                 keyMessage: "DETAIL_STORE_NO_FOOD",
//                 style: const TextStyle(
//                   fontSize: 18,
//                   color: Colors.red,
//                 ),
//               ),
//             ),
//           const SizedBox(
//             height: 16,
//           ),
//           Container(
//             width: widget.width,
//             height: 1,
//             color: ColorPalette.distanceColor,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget categoryList(List<dynamic> filtersAndFoods) {
//     _categoryHeaderKeys.clear();
//     _categoryItemsKeys.clear();
//
//     if (filtersAndFoods.isEmpty) return const SizedBox();
//
//     return ListView.builder(
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       itemCount: filtersAndFoods.length,
//       itemBuilder: (context, index) {
//         FilterAndFood menu = filtersAndFoods[index];
//
//         GlobalKey headerKey = GlobalKey();
//         GlobalKey itemsKey = GlobalKey();
//         _categoryHeaderKeys.add(headerKey);
//         _categoryItemsKeys.add(itemsKey);
//
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               key: headerKey,
//               padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
//               child: Text(
//                 (menu.name).toUpperCase(),
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             ListView.separated(
//               key: itemsKey,
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: menu.foods!.length,
//               itemBuilder: (context, itemIndex) {
//                 return FoodItem(food: menu.foods![itemIndex]);
//               },
//               separatorBuilder: (context, itemIndex) =>
//               const SizedBox(height: 10),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void _scrollToCategoryHeader(int categoryIndex) async {
//     if (categoryIndex == -1) return;
//     setState(() {
//       _selectedCategoryIndex = categoryIndex;
//       _isProgrammaticScroll = true;
//     });
//
//     RenderBox? intro1 =
//     widget.introKey.currentContext?.findRenderObject() as RenderBox?;
//     RenderBox? intro2 =
//     widget.introKey2.currentContext?.findRenderObject() as RenderBox?;
//     double intro1Height = intro1?.size.height ?? 0;
//     double intro2Height = intro2?.size.height ?? 0;
//
//     double offset = intro1Height + intro2Height;
//     for (int i = 0; i < categoryIndex; i++) {
//       double headerHeight = _getCategoryHeaderHeight(i);
//       double itemsHeight = _getCategoryItemsHeight(i);
//       offset += headerHeight + itemsHeight;
//     }
//
//     widget.controller.animateTo(
//       offset,
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//     ).then((_) {
//       Future.delayed(const Duration(milliseconds: 300), () {
//         setState(() {
//           _isProgrammaticScroll = false;
//         });
//       });
//     });
//
//   }
//
//   double _getCategoryHeaderHeight(int index) {
//     final RenderBox renderBox = _categoryHeaderKeys[index]
//         .currentContext!
//         .findRenderObject() as RenderBox;
//     return renderBox.size.height;
//   }
//
//   double _getCategoryItemsHeight(int index) {
//     final RenderBox renderBox = _categoryItemsKeys[index]
//         .currentContext!
//         .findRenderObject() as RenderBox;
//     return renderBox.size.height;
//   }
// }
