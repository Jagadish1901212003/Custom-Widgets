import 'package:custom_widgets/model/dropdown_item_model.dart';
import 'package:custom_widgets/utility/app_colors.dart';
import 'package:custom_widgets/view/Screens/ca_description_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart';

class CorrectiveActionsInCustomTabBarScreen extends StatefulWidget {
  const CorrectiveActionsInCustomTabBarScreen({super.key});

  @override
  State<CorrectiveActionsInCustomTabBarScreen> createState() =>
      _CorrectiveActionsInCustomTabBarScreenState();
}

class _CorrectiveActionsInCustomTabBarScreenState
    extends State<CorrectiveActionsInCustomTabBarScreen> {
  // List<Map<String, dynamic>> submittedCorrectiveActions = [] ;

  // List<Map<String, dynamic>> submittedCorrectiveActions1 =submittedCorrectiveActions;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Align(
            alignment: AlignmentGeometry.topRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors
                    .appPrimaryColor, // Set button background color to blue
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5), // border radius of 5
                ),
              ),
              child: const Text(
                '+ Add More',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                final uniqueId = DateTime.now().millisecondsSinceEpoch
                    .toString();

                final result = await Navigator.of(context)
                    .push<Map<String, dynamic>>(
                      MaterialPageRoute(
                        builder: (context) =>
                            CaDescriptionScreen(uniqueId: uniqueId),
                      ),
                    );

                if (result != null && result.isNotEmpty) {
                  setState(() {
                    submittedCorrectiveActions.add(result);
                    // print("status1234: ${result["status"] as DropdownItemModel).name}");
                    print(
                      "status  ${(result["status"] as DropdownItemModel).name}",
                    );
                  });
                }
              },
            ),
          ),
        ),

        const SizedBox(height: 10),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: submittedCorrectiveActions.length,
          itemBuilder: (context, index) {
            try {
              final action = submittedCorrectiveActions[index];
              print("action from corrective action : $action");
              print(
                "submittedCorrectiveActions from corrective action : $submittedCorrectiveActions",
              );

              final caCategory =
                  // (
                  action['caCategory']?.name;
              print("${caCategory} ========================1");
              // as List<dynamic>?)?.join(', ') ?? 'N/A';
              final priority = action['priority']?.name;
              // (action['priority'] as List<dynamic>?)?.join(', ') ?? 'N/A';
              final assignTo = action['assignTo'] ?? 'N/A';
              final caDescription = action['caDescription'] ?? 'N/A';

              print("$caDescription $priority $assignTo $caCategory");
              // } catch (e) {
              //   print(" error : $e");
              // }

              return Container(
                // color: Colors.white,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                // elevation: 3,
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(10),
                // ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabeledText('CA Category:', caCategory),
                      const SizedBox(height: 4),
                      _buildLabeledText(
                        'Priority:',
                        priority,
                        labelColor: Colors.blueAccent,
                      ),
                      const SizedBox(height: 4),
                      _buildLabeledText('Assign To:', assignTo),
                      const SizedBox(height: 8),
                      _buildLabeledText('Description:', caDescription),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.green),
                            tooltip: 'Edit',
                            onPressed: () async {
                              print("action ==============");
                              print(
                                "12345 ${(action["status"] as DropdownItemModel).name}",
                              );
                              final editedResult = await Navigator.of(context)
                                  .push<Map<String, dynamic>>(
                                    MaterialPageRoute(
                                      builder: (context) => CaDescriptionScreen(
                                        uniqueId:
                                            action['uniqueId'], // <-- pass stored ID from the item
                                        existingData: action,
                                      ),
                                    ),
                                  );

                              if (editedResult != null &&
                                  editedResult.isNotEmpty) {
                                setState(() {
                                  submittedCorrectiveActions[index] =
                                      editedResult;
                                });
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            tooltip: 'Delete',
                            // onPressed: () {
                            //   setState(() {
                            //     submittedCorrectiveActions.removeAt(index);
                            //   });
                            // },
                            onPressed: () async {
                              final uniqueId =
                                  submittedCorrectiveActions[index]['uniqueId'];
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.remove('document_paths_$uniqueId');
                              await prefs.remove('photo_paths_$uniqueId');

                              setState(() {
                                submittedCorrectiveActions.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } catch (e) {
              print(" error : $e");
            }
          },
        ),
      ],
    );
  }

  Widget _buildLabeledText(
    String label,
    String value, {
    Color labelColor = Colors.black87,
  }) {
    return RichText(
      text: TextSpan(
        text: '$label ',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: labelColor,
          fontSize: 14,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
