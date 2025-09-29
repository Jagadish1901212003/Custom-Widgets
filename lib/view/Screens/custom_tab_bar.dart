import 'package:custom_widgets/model/dropdown_item_model.dart';
import 'package:flutter/material.dart';

class CustomTabBarItem {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  CustomTabBarItem({required this.icon, required this.label, this.onTap});
}

class CustomTabBar extends StatelessWidget {
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
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(items.length, (index) {
            if ((selectedInspectionType?.name ==
                        "Environmental Site Evaluation" ||
                    selectedInspectionType?.name == "Property Review" ||
                    selectedInspectionType?.name == "Sample Collection") &&
                index == 1) {
              return const SizedBox();
            }

            final item = items[index];
            final isSelected = index == selectedIndex;

            return GestureDetector(
              onTap: () {
                item.onTap?.call(); // Call any internal onTap
                onTap?.call(index); // Notify parent of selection change
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item.icon,
                      color: isSelected ? selectedColor : unselectedColor,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.label,
                      style: TextStyle(
                        color: isSelected ? selectedColor : unselectedColor,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
