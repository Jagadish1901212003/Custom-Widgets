import 'package:flutter/material.dart';
import 'package:custom_widgets/utility/app_colors.dart';

class NoDataWidget extends StatelessWidget {
  final IconData icon;
  final String message;
  final String subtitle;

  const NoDataWidget({
    super.key,
    this.message = "No data Available",
    this.icon = Icons.folder_open,
    this.subtitle = "Nothing to display here",
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Simple circle with soft background
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.appPrimaryColor.withValues(
                alpha: 0.1,
              ), // light tint
            ),
            child: Icon(icon, size: 45, color: AppColors.appPrimaryColor),
          ),
          const SizedBox(height: 14),

          // Main message
          Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 6),

          // Subtitle for clarity
          Text(subtitle, style: TextStyle(fontSize: 13, color: Colors.black45)),
        ],
      ),
    );
  }
}
