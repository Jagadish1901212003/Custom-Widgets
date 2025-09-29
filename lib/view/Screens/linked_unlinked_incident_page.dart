import 'package:flutter/material.dart';

class LinkedUnlinkedIncidentPage extends StatelessWidget {
  const LinkedUnlinkedIncidentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Link/Unlinked Incident"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Link Incident Button
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
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
                label: const Text(
                  "Link Incident",
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(width: 12), // spacing between buttons
            // Unlink Incident Button
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
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
                label: const Text(
                  "Unlink Incident",
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
