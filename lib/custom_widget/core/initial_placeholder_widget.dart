import 'package:flutter/material.dart';
import 'package:custom_widgets/utility/app_colors.dart';

class InitialPlaceholderWidget extends StatelessWidget {
  const InitialPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/incident_placeholder.png", width: 200),
            const SizedBox(height: 25),
            const Text(
              "Report Incident",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Roboto',
                color: AppColors.appPrimaryTextColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: const Text(
                "To report incident please select inspection type.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 12,
                  color: AppColors.appSecondaryTextColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
