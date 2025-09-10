import 'package:flutter/material.dart';
import 'package:custom_widgets/utility/app_colors.dart';

class NoSearchDataWidget extends StatelessWidget {
  const NoSearchDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Circle background
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.appPrimaryColor.withValues(alpha: 0.1),
            ),
            child: const Icon(
              Icons.search_off,
              size: 45,
              color: AppColors.appPrimaryColor,
            ),
          ),
          const SizedBox(height: 14),

          // Main message
          Text(
            "No data found",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 6),

          // Subtitle
          const Text(
            "No search results found",
            style: TextStyle(fontSize: 13, color: Colors.black45),
          ),
        ],
      ),
    );
  }
}
