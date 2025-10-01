import 'package:custom_widgets/utility/app_colors.dart';
import 'package:flutter/material.dart';

class LinkedUnlinkedIncidentPage extends StatelessWidget {
  final String btnName1;
  final String btnName2;

  const LinkedUnlinkedIncidentPage({
    super.key,
    required this.btnName1,
    required this.btnName2,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Link/Unlinked Incident"),
        backgroundColor: AppColors.appPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Link Incident Button
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.appPrimaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 12, // reduced to allow text shrink
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  // TODO: Add your navigation or logic here
                },
                icon: const Icon(Icons.link),
                label: Text(btnName1, overflow: TextOverflow.ellipsis),
              ),
            ),
            const SizedBox(width: 12), // spacing between buttons
            // Unlink Incident Button
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.appPrimaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 12,
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  // TODO: Add your navigation or logic here
                },
                icon: const Icon(Icons.link_off),
                label: Text(btnName2, overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
