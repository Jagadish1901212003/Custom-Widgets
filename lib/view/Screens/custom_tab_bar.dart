// import 'package:custom_widgets/model/dropdown_item_model.dart';
// import 'package:custom_widgets/utility/app_colors.dart';
// import 'package:flutter/material.dart';

// class CustomTabBarItem {
//   final IconData icon;
//   final String label;
//   final VoidCallback? onTap;

//   CustomTabBarItem({required this.icon, required this.label, this.onTap});
// }

// class CustomTabBar extends StatelessWidget {
//   final List<CustomTabBarItem> items;
//   final int selectedIndex;
//   final void Function(int index)? onTap;
//   final Color selectedColor;
//   final Color unselectedColor;
//   final DropdownItemModel? selectedInspectionType;

//   const CustomTabBar({
//     this.selectedInspectionType,
//     super.key,
//     required this.items,
//     this.selectedIndex = 0,
//     this.onTap,
//     this.selectedColor = AppColors.appPrimaryColor,
//     this.unselectedColor = Colors.grey,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 60,
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           children: List.generate(items.length, (index) {
//             if ((selectedInspectionType?.name ==
//                         "Environmental Site Evaluation" ||
//                     selectedInspectionType?.name == "Property Review" ||
//                     selectedInspectionType?.name == "Sample Collection") &&
//                 index == 1) {
//               return const SizedBox();
//             }

//             final item = items[index];
//             final isSelected = index == selectedIndex;

//             return GestureDetector(
//               onTap: () {
//                 item.onTap?.call(); // Call any internal onTap
//                 onTap?.call(index); // Notify parent of selection change
//               },
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       item.icon,
//                       color: isSelected ? selectedColor : unselectedColor,
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       item.label,
//                       style: TextStyle(
//                         color: isSelected ? selectedColor : unselectedColor,
//                         fontWeight: isSelected
//                             ? FontWeight.bold
//                             : FontWeight.normal,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }

// import 'package:custom_widgets/model/dropdown_item_model.dart';
// import 'package:custom_widgets/utility/app_colors.dart';
// import 'package:flutter/material.dart';

// class CustomTabBarItem {
//   final IconData icon;
//   final String label;
//   final VoidCallback? onTap;

//   CustomTabBarItem({required this.icon, required this.label, this.onTap});
// }

// class CustomTabBar extends StatefulWidget {
//   final List<CustomTabBarItem> items;
//   final int selectedIndex;
//   final void Function(int index)? onTap;
//   final Color selectedColor;
//   final Color unselectedColor;
//   final DropdownItemModel? selectedInspectionType;

//   const CustomTabBar({
//     this.selectedInspectionType,
//     super.key,
//     required this.items,
//     this.selectedIndex = 0,
//     this.onTap,
//     this.selectedColor = AppColors.appPrimaryColor,
//     this.unselectedColor = Colors.grey,
//   });

//   @override
//   State<CustomTabBar> createState() => _CustomTabBarState();
// }

// class _CustomTabBarState extends State<CustomTabBar> {
//   late int _currentIndex;

//   @override
//   void initState() {
//     super.initState();
//     _currentIndex = widget.selectedIndex;
//   }

//   @override
//   void didUpdateWidget(covariant CustomTabBar oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.selectedIndex != _currentIndex) {
//       setState(() {
//         _currentIndex = widget.selectedIndex;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       // height: 70,
//       child: Stack(
//         children: [
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: List.generate(widget.items.length, (index) {
//                 // Conditional hide for certain tabs
//                 if ((widget.selectedInspectionType?.name ==
//                             "Environmental Site Evaluation" ||
//                         widget.selectedInspectionType?.name ==
//                             "Property Review" ||
//                         widget.selectedInspectionType?.name ==
//                             "Sample Collection") &&
//                     index == 1) {
//                   return const SizedBox();
//                 }

//                 final item = widget.items[index];
//                 final isSelected = index == _currentIndex;

//                 return GestureDetector(
//                   onTap: () {
//                     // setState(() {
//                     //   _currentIndex = index;
//                     // });
//                     item.onTap?.call();
//                     widget.onTap?.call(index);
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 10,
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           item.icon,
//                           color: isSelected
//                               ? widget.selectedColor
//                               : widget.unselectedColor,
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           item.label,
//                           style: TextStyle(
//                             color: isSelected
//                                 ? widget.selectedColor
//                                 : widget.unselectedColor,
//                             fontWeight: isSelected
//                                 ? FontWeight.bold
//                                 : FontWeight.normal,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }),
//             ),
//           ),
//           // Animated indicator
//           Positioned(
//             bottom: 0,
//             left: _calculateIndicatorPosition(context),
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.easeInOut,
//               height: 3,
//               width: _calculateIndicatorWidth(context),
//               decoration: BoxDecoration(
//                 color: widget.selectedColor,
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   double _calculateIndicatorPosition(BuildContext context) {
//     // Get widths of each tab to position indicator
//     double position = 0;
//     for (int i = 0; i < _currentIndex; i++) {
//       final item = widget.items[i];
//       position += _getTabWidth(item.label) + 40; // padding horizontal * 2
//     }
//     return position;
//   }

//   double _calculateIndicatorWidth(BuildContext context) {
//     final item = widget.items[_currentIndex];
//     return _getTabWidth(item.label);
//   }

//   double _getTabWidth(String label) {
//     // Rough width calculation for indicator
//     final TextPainter textPainter = TextPainter(
//       text: TextSpan(
//         text: label,
//         style: const TextStyle(fontWeight: FontWeight.bold),
//       ),
//       maxLines: 1,
//       textDirection: TextDirection.ltr,
//     )..layout();

//     return textPainter.size.width;
//   }
// }

// import 'package:custom_widgets/model/dropdown_item_model.dart';
// import 'package:custom_widgets/utility/app_colors.dart';
// import 'package:flutter/material.dart';

// class CustomTabBarItem {
//   final IconData icon;
//   final String label;
//   final VoidCallback? onTap;

//   CustomTabBarItem({required this.icon, required this.label, this.onTap});
// }

// class CustomTabBar extends StatefulWidget {
//   final List<CustomTabBarItem> items;
//   final int selectedIndex;
//   final void Function(int index)? onTap;
//   final Color selectedColor;
//   final Color unselectedColor;
//   final DropdownItemModel? selectedInspectionType;

//   const CustomTabBar({
//     this.selectedInspectionType,
//     super.key,
//     required this.items,
//     this.selectedIndex = 0,
//     this.onTap,
//     this.selectedColor = AppColors.appPrimaryColor,
//     this.unselectedColor = Colors.grey,
//   });

//   @override
//   State<CustomTabBar> createState() => _CustomTabBarState();
// }

// class _CustomTabBarState extends State<CustomTabBar> {
//   late int _currentIndex;

//   @override
//   void initState() {
//     super.initState();
//     _currentIndex = widget.selectedIndex;
//   }

//   @override
//   void didUpdateWidget(covariant CustomTabBar oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.selectedIndex != _currentIndex) {
//       setState(() {
//         _currentIndex = widget.selectedIndex;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final totalTabs = widget.items.length;
//     final screenWidth = MediaQuery.of(context).size.width;
//     final tabWidth = screenWidth / totalTabs;

//     return Container(
//       color: Colors.white,
//       // height: 70,
//       child: Stack(
//         children: [
//           Row(
//             children: List.generate(widget.items.length, (index) {
//               // Conditional hide for certain tabs
//               if ((widget.selectedInspectionType?.name ==
//                           "Environmental Site Evaluation" ||
//                       widget.selectedInspectionType?.name ==
//                           "Property Review" ||
//                       widget.selectedInspectionType?.name ==
//                           "Sample Collection") &&
//                   index == 1) {
//                 return const SizedBox(width: 0);
//               }

//               final item = widget.items[index];
//               final isSelected = index == _currentIndex;

//               return GestureDetector(
//                 onTap: () {
//                   // setState(() {
//                   //   _currentIndex = index;
//                   // });
//                   item.onTap?.call();
//                   widget.onTap?.call(index);
//                 },
//                 child: Container(
//                   width: tabWidth,
//                   alignment: Alignment.center,
//                   // padding: const EdgeInsets.symmetric(vertical: 8),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         item.icon,
//                         color: isSelected
//                             ? widget.selectedColor
//                             : widget.unselectedColor,
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         item.label,
//                         style: TextStyle(
//                           color: isSelected
//                               ? widget.selectedColor
//                               : widget.unselectedColor,
//                           fontWeight: isSelected
//                               ? FontWeight.bold
//                               : FontWeight.normal,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }),
//           ),
//           // Sliding indicator
//           AnimatedPositioned(
//             duration: const Duration(milliseconds: 300),
//             curve: Curves.easeInOut,
//             bottom: 0,
//             left: tabWidth * _currentIndex,
//             child: Container(
//               width: tabWidth,
//               height: 3,
//               decoration: BoxDecoration(
//                 color: widget.selectedColor,
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:custom_widgets/model/dropdown_item_model.dart';
// import 'package:custom_widgets/utility/app_colors.dart';
// import 'package:flutter/material.dart';

// class CustomTabBarItem {
//   final IconData icon;
//   final String label;
//   final VoidCallback? onTap;

//   CustomTabBarItem({required this.icon, required this.label, this.onTap});
// }

// class CustomTabBar extends StatefulWidget {
//   final List<CustomTabBarItem> items;
//   final int selectedIndex;
//   final void Function(int index)? onTap;
//   final Color selectedColor;
//   final Color unselectedColor;
//   final DropdownItemModel? selectedInspectionType;

//   const CustomTabBar({
//     this.selectedInspectionType,
//     super.key,
//     required this.items,
//     this.selectedIndex = 0,
//     this.onTap,
//     this.selectedColor = AppColors.appPrimaryColor,
//     this.unselectedColor = Colors.grey,
//   });

//   @override
//   State<CustomTabBar> createState() => _CustomTabBarState();
// }

// class _CustomTabBarState extends State<CustomTabBar> {
//   late int _currentIndex;

//   @override
//   void initState() {
//     super.initState();
//     _currentIndex = widget.selectedIndex;
//   }

//   @override
//   void didUpdateWidget(covariant CustomTabBar oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.selectedIndex != _currentIndex) {
//       setState(() {
//         _currentIndex = widget.selectedIndex;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final totalTabs = widget.items.length;
//     final screenWidth = MediaQuery.of(context).size.width;
//     final tabWidth = screenWidth / totalTabs;
//     const double tabHeight = 90; // fixed height for consistency

//     return Container(
//       color: Colors.white,
//       height: tabHeight,
//       child: Stack(
//         children: [
//           Row(
//             children: List.generate(widget.items.length, (index) {
//               // Conditional hide for certain tabs
//               if ((widget.selectedInspectionType?.name ==
//                           "Environmental Site Evaluation" ||
//                       widget.selectedInspectionType?.name ==
//                           "Property Review" ||
//                       widget.selectedInspectionType?.name ==
//                           "Sample Collection") &&
//                   index == 1) {
//                 return const SizedBox(width: 0);
//               }

//               final item = widget.items[index];
//               final isSelected = index == _currentIndex;

//               return GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     _currentIndex = index;
//                   });
//                   item.onTap?.call();
//                   widget.onTap?.call(index);
//                 },
//                 child: Container(
//                   width: tabWidth,
//                   height: tabHeight,
//                   alignment: Alignment.topCenter, // icon starts at top
//                   padding: const EdgeInsets.only(top: 6),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(
//                         item.icon,
//                         color: isSelected
//                             ? widget.selectedColor
//                             : widget.unselectedColor,
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         item.label,
//                         style: TextStyle(
//                           color: isSelected
//                               ? widget.selectedColor
//                               : widget.unselectedColor,
//                           fontWeight: isSelected
//                               ? FontWeight.bold
//                               : FontWeight.normal,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }),
//           ),
//           // Sliding indicator
//           AnimatedPositioned(
//             duration: const Duration(milliseconds: 300),
//             curve: Curves.easeInOut,
//             bottom: 0,
//             left: tabWidth * _currentIndex,
//             child: Container(
//               width: tabWidth,
//               height: 3,
//               decoration: BoxDecoration(
//                 color: widget.selectedColor,
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:custom_widgets/model/dropdown_item_model.dart';
// import 'package:custom_widgets/utility/app_colors.dart';
// import 'package:flutter/material.dart';

// class CustomTabBarItem {
//   final IconData icon;
//   final String label;
//   final VoidCallback? onTap;

//   CustomTabBarItem({required this.icon, required this.label, this.onTap});
// }

// class CustomTabBar extends StatefulWidget {
//   final List<CustomTabBarItem> items;
//   final int selectedIndex;
//   final void Function(int index)? onTap;
//   final Color selectedColor;
//   final Color unselectedColor;
//   final DropdownItemModel? selectedInspectionType;

//   const CustomTabBar({
//     this.selectedInspectionType,
//     super.key,
//     required this.items,
//     this.selectedIndex = 0,
//     this.onTap,
//     this.selectedColor = AppColors.appPrimaryColor,
//     this.unselectedColor = Colors.grey,
//   });

//   @override
//   State<CustomTabBar> createState() => _CustomTabBarState();
// }

// class _CustomTabBarState extends State<CustomTabBar>
//     with SingleTickerProviderStateMixin {
//   late int _currentIndex;
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   late double _indicatorLeft;

//   @override
//   void initState() {
//     super.initState();
//     _currentIndex = widget.selectedIndex;

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     );

//     // Calculate initial indicator position
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final screenWidth = MediaQuery.of(context).size.width;
//       final totalTabs = widget.items.length;
//       final tabWidth = screenWidth / totalTabs;

//       setState(() {
//         _indicatorLeft = tabWidth * _currentIndex;
//         _animation = Tween<double>(begin: _indicatorLeft, end: _indicatorLeft)
//             .animate(
//               CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//             );
//       });
//     });
//   }

//   void _animateIndicator(double newLeft) {
//     _animation = Tween<double>(
//       begin: _indicatorLeft,
//       end: newLeft,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
//     _controller.reset();
//     _controller.forward();
//     _indicatorLeft = newLeft;
//   }

//   @override
//   void didUpdateWidget(covariant CustomTabBar oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.selectedIndex != _currentIndex) {
//       setState(() {
//         _currentIndex = widget.selectedIndex;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final totalTabs = widget.items.length;
//     final screenWidth = MediaQuery.of(context).size.width;
//     final tabWidth = screenWidth / totalTabs;
//     const double tabHeight = 94; // fixed height
//     const double indicatorBottomPadding = 12; // space from icon/text

//     return Container(
//       color: Colors.white,
//       height: tabHeight,
//       child: Stack(
//         children: [
//           Row(
//             children: List.generate(widget.items.length, (index) {
//               // Conditional hide for certain tabs
//               if ((widget.selectedInspectionType?.name ==
//                           "Environmental Site Evaluation" ||
//                       widget.selectedInspectionType?.name ==
//                           "Property Review" ||
//                       widget.selectedInspectionType?.name ==
//                           "Sample Collection") &&
//                   index == 1) {
//                 return const SizedBox(width: 0);
//               }

//               final item = widget.items[index];
//               final isSelected = index == _currentIndex;

//               return GestureDetector(
//                 onTap: () {
//                   final newLeft = tabWidth * index;
//                   _animateIndicator(newLeft);

//                   setState(() {
//                     _currentIndex = index;
//                   });
//                   item.onTap?.call();
//                   widget.onTap?.call(index);
//                 },
//                 child: Container(
//                   width: tabWidth,
//                   height: tabHeight,
//                   alignment: Alignment.topCenter,
//                   padding: const EdgeInsets.only(top: 4),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(
//                         item.icon,
//                         color: isSelected
//                             ? widget.selectedColor
//                             : widget.unselectedColor,
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         item.label,
//                         style: TextStyle(
//                           color: isSelected
//                               ? widget.selectedColor
//                               : widget.unselectedColor,
//                           fontWeight: isSelected
//                               ? FontWeight.bold
//                               : FontWeight.normal,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }),
//           ),
//           // Sliding indicator
//           if (_animation != null)
//             AnimatedBuilder(
//               animation: _animation,
//               builder: (context, child) {
//                 return Positioned(
//                   bottom: indicatorBottomPadding,
//                   left: _animation.value,
//                   child: Container(
//                     width: tabWidth,
//                     height: 3,
//                     decoration: BoxDecoration(
//                       color: widget.selectedColor,
//                       borderRadius: BorderRadius.circular(2),
//                     ),
//                   ),
//                 );
//               },
//             ),
//         ],
//       ),
//     );
//   }
// }

import 'package:custom_widgets/model/dropdown_item_model.dart';
import 'package:custom_widgets/utility/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTabBarItem {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  CustomTabBarItem({required this.icon, required this.label, this.onTap});
}

class CustomTabBar extends StatefulWidget {
  final List<CustomTabBarItem> items;
  final int selectedIndex;
  final void Function(int index)? onTap;
  final Color selectedColor;
  final Color unselectedColor;
  final DropdownItemModel? selectedInspectionType;

  const CustomTabBar({
    this.selectedInspectionType,
    super.key,
    required this.items,
    this.selectedIndex = 0,
    this.onTap,
    this.selectedColor = AppColors.appPrimaryColor,
    this.unselectedColor = Colors.grey,
  });

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late int _currentIndex;
  late AnimationController _controller;
  late Animation<double> _animation;
  late double _indicatorLeft;

  // @override
  // void initState() {
  //   super.initState();
  //   _currentIndex = widget.selectedIndex;

  //   _controller = AnimationController(
  //     vsync: this,
  //     duration: const Duration(milliseconds: 300),
  //   );

  //   // Calculate initial indicator position
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     final screenWidth = MediaQuery.of(context).size.width;
  //     final totalTabs = widget.items.length;
  //     final tabWidth = screenWidth / totalTabs;

  //     setState(() {
  //       _indicatorLeft = tabWidth * _currentIndex;
  //       _animation = Tween<double>(begin: _indicatorLeft, end: _indicatorLeft)
  //           .animate(
  //             CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
  //           );
  //     });
  //   });
  // }
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.selectedIndex;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Calculate initial indicator position after layout
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final totalTabs = widget.items.length;
      final tabWidth = screenWidth / totalTabs;

      setState(() {
        _indicatorLeft = tabWidth * _currentIndex;
        _animation = Tween<double>(begin: _indicatorLeft, end: _indicatorLeft)
            .animate(
              CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
            );
      });
    });
  }

  void _animateIndicator(double newLeft) {
    _animation = Tween<double>(
      begin: _indicatorLeft,
      end: newLeft,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.reset();
    _controller.forward();
    _indicatorLeft = newLeft;
  }

  @override
  void didUpdateWidget(covariant CustomTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedIndex != _currentIndex) {
      final totalTabs = widget.items.length;
      final screenWidth = MediaQuery.of(context).size.width;
      final tabWidth = screenWidth / totalTabs;

      final newLeft = tabWidth * widget.selectedIndex;

      _animateIndicator(newLeft); // animate sliding bar

      setState(() {
        _currentIndex = widget.selectedIndex; // update selected tab
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalTabs = widget.items.length;
    final screenWidth = MediaQuery.of(context).size.width;
    final tabWidth = screenWidth / totalTabs;
    const double tabHeight = 110; // fixed height
    const double indicatorBottomPadding = 0; // space from icon/text

    return Container(
      color: Colors.white,
      height: tabHeight,
      child: Stack(
        children: [
          Row(
            children: List.generate(widget.items.length, (index) {
              // Conditional hide for certain tabs
              if ((widget.selectedInspectionType?.name ==
                          "Environmental Site Evaluation" ||
                      widget.selectedInspectionType?.name ==
                          "Property Review" ||
                      widget.selectedInspectionType?.name ==
                          "Sample Collection") &&
                  index == 1) {
                return const SizedBox(width: 0);
              }

              final item = widget.items[index];
              final isSelected = index == _currentIndex;

              return GestureDetector(
                onTap: () {
                  // final newLeft = tabWidth * index;
                  // _animateIndicator(newLeft);

                  // setState(() {
                  //   _currentIndex = index;
                  // });
                  item.onTap?.call();
                  widget.onTap?.call(index);
                },
                child: Container(
                  width: tabWidth,
                  height: tabHeight,
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(top: 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item.icon,
                        color: isSelected
                            ? widget.selectedColor
                            : widget.unselectedColor,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.label,
                        style: TextStyle(
                          color: isSelected
                              ? widget.selectedColor
                              : widget.unselectedColor,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          // Sliding indicator
          if (_animation != null)
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Positioned(
                  bottom: indicatorBottomPadding,
                  left: _animation.value,
                  child: Container(
                    width: tabWidth,
                    height: 3,
                    decoration: BoxDecoration(
                      color: widget.selectedColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
