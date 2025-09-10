import 'package:flutter/material.dart';
import 'package:custom_widgets/utility/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  final bool? showLoadingText;
  final String? loadingText;
  final TextStyle? loadingTextStyle;
  final Color? color;
  const LoadingWidget({
    super.key,
    this.showLoadingText = true,
    this.loadingText,
    this.loadingTextStyle,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColors.appPrimaryColor,
            ),
          ),
          if (showLoadingText!) const SizedBox(height: 20),
          if (showLoadingText!)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                loadingText ?? "Loading please wait...",
                textAlign: TextAlign.center,
                style:
                    loadingTextStyle ??
                    const TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 12,
                      color: AppColors.appPrimaryTextColor,
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
